//
//  RequestProtocol.swift
//  Chefsplace
//
//  Created by Dariy Kutelov on 19.05.23.
//

import Foundation

protocol RequestProtocol {
  var path: String { get }
  var requestType: RequestType { get }
  var headers: [String: String] { get }
  var params: [String: Any] { get }
  var urlParams: [String: String?] { get }
  var addAuthorizationToken: Bool { get }
}

// MARK: - Default RequestProtocol

extension RequestProtocol {
  var host: String {
      Constants.Api.host
  }

  var addAuthorizationToken: Bool {
    true
  }

  var params: [String: Any] {
    [:]
  }

  var urlParams: [String: String?] {
    [:]
  }

  var headers: [String: String] {
    [:]
  }

  func createURLRequest(authToken: String) throws -> URLRequest {
    var components = URLComponents()
    //  scheme: Represents the scheme (e.g., "http", "https", "ftp") of the URL.
    //  user: Represents the username component of the URL.
    //  password: Represents the password component of the URL.
    //  host: Represents the host (e.g., "www.example.com") of the URL.
    //  port: Represents the port number component of the URL.
    //  path: Represents the path component of the URL.
    //  query: Represents the query component of the URL (e.g., "key1=value1&key2=value2").
    //  fragment: Represents the fragment component of the URL (e.g., "section1").
    components.scheme = "https"
    components.host = host
    components.path = path

    if !urlParams.isEmpty {
      components.queryItems = urlParams.map {
        URLQueryItem(name: $0, value: $1)
      }
    }

    guard let url = components.url else { throw  NetworkError.invalidURL }

    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = requestType.rawValue

    if !headers.isEmpty {
      urlRequest.allHTTPHeaderFields = headers
    }

    if addAuthorizationToken {
      urlRequest.setValue(authToken, forHTTPHeaderField: "Authorization")
    }

    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

    if !params.isEmpty {
      urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params)
    }

    return urlRequest
  }
}
