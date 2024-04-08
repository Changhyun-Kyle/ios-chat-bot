//
//  NetworkService.swift
//  ChatBot
//
//  Created by 강창현 on 4/3/24.
//

import Foundation
import Combine

struct NetworkService: NetworkTestable {
  
  private let session: URLSessionProtocol
  
  init(session: URLSessionProtocol = MockURLSession(statusCode: 200)) {
    self.session = session
  }
  
  func fetchChatBotResponse<T:Encodable>(
    type: APIType,
    httpMethod: HttpMethod<T>
  ) -> AnyPublisher<ResponseModel, NetworkError> {
    guard
      let urlRequest = try? NetworkURL.makeURLRequest(type: type, httpMethod: httpMethod)
    else {
      return Fail(error: NetworkError.requestFailError).eraseToAnyPublisher()
    }
    return session.dataTaskPublisher(for: urlRequest)
      .eraseToAnyPublisher()
  }
}
