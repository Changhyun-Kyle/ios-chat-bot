//
//  NetworkTestable.swift
//  ChatBot
//
//  Created by 강창현 on 4/3/24.
//

import Foundation
import Combine

protocol NetworkTestable {
  func setMockSession(session: URLSessionProtocol) -> NetworkService
}

extension NetworkTestable {
  func setMockSession(session: URLSessionProtocol) -> NetworkService {
    return NetworkService(session: session)
  }
}
