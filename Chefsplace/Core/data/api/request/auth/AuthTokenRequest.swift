//
//  AuthTokenRequest.swift
//  Chefsplace
//
//  Created by Dariy Kutelov on 19.05.23.
//

import Foundation

enum AuthTokenRequest: RequestProtocol {
  case auth

  var path: String {
    "/api/v1/user/token"
  }

  var addAuthorizationToken: Bool {
    false
  }

  var requestType: RequestType {
    .POST
  }
}
