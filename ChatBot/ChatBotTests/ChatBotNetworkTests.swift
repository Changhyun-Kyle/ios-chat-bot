//
//  ChatBotNetworkTests.swift
//  ChatBotTests
//
//  Created by 강창현 on 4/3/24.
//

import XCTest
import Combine
@testable import ChatBot

final class ChatBotNetworkTests: XCTestCase {
  var cancellables: Set<AnyCancellable>!
  
  override func setUpWithError() throws {
    cancellables = .init()
  }
  
  override func tearDownWithError() throws {
    cancellables = nil
  }
  
  func test_http상태코드가_200_이면_receiveValue의_data가_notNil이다() throws {
    // given
    let mockURLSession = MockURLSession(statusCode: 200)
    let sut = setMockSession(session: mockURLSession)
    
    // when
    sut.fetchChatBotResponse(type: .chatbot, httpMethod: .POST(body: MockDataSample.requestData))
      .sink { completion in
        switch completion {
        case .finished:
          break
        case .failure(let error):
          XCTFail(error.localizedDescription)
        }
      } receiveValue: { data in
        // then
        XCTAssertNotNil(data)
      }.store(in: &cancellables)
  }
  
  func test_http상태코드가_400_이면_clientError가_발생한다() throws {
    // given
    let mockURLSession = MockURLSession(statusCode: 400)
    let sut = setMockSession(session: mockURLSession)
    
    // when
    sut.fetchChatBotResponse(type: .chatbot, httpMethod: .POST(body: MockDataSample.requestData))
      .sink { completion in
        switch completion {
        case .finished:
          XCTFail()
        case .failure(let error):
          // then
          XCTAssertEqual(
            error.localizedDescription,
            NetworkError.clientError.localizedDescription
          )
        }
      } receiveValue: { data in
        XCTFail()
      }.store(in: &cancellables)
  }
}

extension ChatBotNetworkTests: NetworkTestable { }
