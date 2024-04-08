//
//  URLSession+.swift
//  ChatBot
//
//  Created by 강창현 on 4/3/24.
//

import Foundation
import Combine

protocol URLSessionProtocol {
  func dataTaskPublisher<T: Decodable>(for request: URLRequest) -> AnyPublisher<T,NetworkError>
  func handleHTTPResponse(data: Data,httpResponse: URLResponse) throws -> Data
}

extension URLSessionProtocol {
  func handleHTTPResponse(data: Data,httpResponse: URLResponse) throws -> Data {
    guard let httpResponse = httpResponse as? HTTPURLResponse else {
      throw NetworkError.unknownError
    }
    switch httpResponse.statusCode {
    case 200..<300:
      return data
    case 300..<400:
      throw NetworkError.redirectionError
    case 400..<500:
      throw NetworkError.clientError
    case 500..<600:
      throw NetworkError.serverError
    default:
      throw NetworkError.unknownError
    }
  }
}

extension URLSession: URLSessionProtocol {
  func dataTaskPublisher<T: Decodable>(
    for request: URLRequest
  ) -> AnyPublisher<T, NetworkError> {
    return self.dataTaskPublisher(for: request)
      .tryMap { (data: Data, response: URLResponse) in
        try self.handleHTTPResponse(data: data, httpResponse: response)
      }
      .mapError { error in
        error as? NetworkError ?? NetworkError.networkError(error)
      }
      .decode(type: T.self, decoder: JSONHandler.decoder)
      .mapError { error in
        error as? NetworkError ?? NetworkError.decodingError
      }
      .eraseToAnyPublisher()
  }
}
