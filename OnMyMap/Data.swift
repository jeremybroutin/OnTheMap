//
//  Data.swift
//  OnMyMap
//
//  Created by Jeremy Broutin on 7/16/15.
//  Copyright (c) 2015 Jeremy Broutin. All rights reserved.
//

import Foundation
import MapKit


class Data: NSObject {
  
  // Udacity username and password
  var username: String!
  var password: String!
  
  // Udacity student data
  var userID: String!
  var userFirstName: String!
  var userLastName: String!
  
  // Facebook data
  var fbAccessToken: String!
  
  // Parse data
  var studentsLocations: [StudentLocation]!
  var objectID: String!
  var mapString: String!
  var mediaURL: String!
  var region: MKCoordinateRegion!
  var userHasExistingLocation: Bool!
  
  // MARK: - Shared Instance
  class func sharedInstance() -> Data {
    struct Singleton {
      static var sharedInstance = Data()
    }
  return Singleton.sharedInstance
  }
}