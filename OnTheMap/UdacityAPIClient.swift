//
//  UdacityAPIClient.swift
//  OnTheMap
//
//  Created by Jeremy Broutin on 7/16/15.
//  Copyright (c) 2015 Jeremy Broutin. All rights reserved.
//

import Foundation

class UdacityAPIClient: NSObject {
  
  // Shared session
  var session: NSURLSession
  
  override init() {
    session = NSURLSession.sharedSession()
    super.init()
  }
  
  // MARK: - task for POST Method
  func taskForPostMethod(method: String, jsonBody: [String:AnyObject], completionHandler: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
    
    // 1- Set the parameters
    //Defined in the jsonBody argument
    
    // 2- Build the url
    let urlString = Constants.baseSecureURLString + method
    let url = NSURL(string: urlString)!
    
    // 3- Configure the request
    let request = NSMutableURLRequest(URL: url)
    request.HTTPMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    var jsonifyError: NSError? = nil
    request.HTTPBody = NSJSONSerialization.dataWithJSONObject(jsonBody, options: nil, error: &jsonifyError)
    
    // 4- Make the request
    let task = session.dataTaskWithRequest(request) { data, response, downloadError in
      
      // 5&6- Parse and use the data
      if let error = downloadError {
        let newError = UdacityAPIClient.errorForData(data, response: response, error: error)
        completionHandler(result: nil, error: newError)
      }
      else {
        UdacityAPIClient.parseJSONWithCompletionHandler(data, completionHandler: completionHandler)
      }
    }
    
    
    // 7- Start the request
    task.resume()
    
    return task
    
  }
  
  // MARK: - Shared Instance
  class func sharedInstance() -> UdacityAPIClient {
    struct Singleton {
      static var sharedInstance = UdacityAPIClient()
    }
    return Singleton.sharedInstance
  }
  
  
}