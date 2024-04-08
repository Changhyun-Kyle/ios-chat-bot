//
//  NetworkURL.swift
//  ChatBot
//
//  Created by 강창현 on 4/4/24.
//

import Foundation

enum NetworkURL {
  static func makeURLRequest<T: Encodable>(
    type: APIType,
    httpMethod: HttpMethod<T>
  ) throws -> URLRequest? {
    let url = try makeURL(type: type)
    var urlRequest = URLRequest(url: url)
    
    let httpConfiguration = httpMethod.configuration
    urlRequest.httpMethod = httpConfiguration.method.type
    urlRequest.allHTTPHeaderFields = type.header
    guard
      let body = httpConfiguration.body
    else {
      return urlRequest
    }
    urlRequest.httpBody = try JSONHandler.handleEncodedData(data: body)
    return urlRequest
  }
  
  private static func makeURL(type: APIType) throws -> URL {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = type.host
    urlComponents.path = type.path
    
    guard
      let url = urlComponents.url
    else {
      throw NetworkError.invalidURLError
    }
    return url
  }
}
