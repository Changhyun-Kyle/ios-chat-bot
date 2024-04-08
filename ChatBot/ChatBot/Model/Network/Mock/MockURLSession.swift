//
//  MockURLSession.swift
//  ChatBot
//
//  Created by 강창현 on 4/3/24.
//

import Foundation
import Combine

final class MockURLSession: URLSessionProtocol {
  typealias Response = AnyPublisher<(Data, URLResponse), NetworkError>
  
  private var response: Response?
  
  init(statusCode: Int) {
    self.makeResponse(statusCode: statusCode)
  }
  
  private func makeResponse(statusCode: Int) {
    let data: Data = JSONHandler.load(fileName: "MockData")!
    let httpResponse = HTTPURLResponse(
      url: URL(string: "www.naver.com")!,
      statusCode: statusCode,
      httpVersion: nil,
      headerFields: nil
    )! as URLResponse
    let response = Just((data, httpResponse))
      .setFailureType(to: NetworkError.self)
      .eraseToAnyPublisher()
    self.response = response
  }
  
  func dataTaskPublisher<T: Decodable>(for request: URLRequest) -> AnyPublisher<T, NetworkError> {
    guard
      let response
    else {
      return Fail(error: NetworkError.unknownError).eraseToAnyPublisher()
    }
    return response
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
