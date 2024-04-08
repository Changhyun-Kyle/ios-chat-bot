//
//  ChatBotTests.swift
//  ChatBotTests
//
//  Created by 강창현 on 4/2/24.
//

import XCTest
import Combine
@testable import ChatBot

final class ChatBotTests: XCTestCase {
  var sut: ChatViewModel!
  var input: PassthroughSubject<ChatViewModel.Input, Never>!
  var cancellables: Set<AnyCancellable>!
  
  override func setUpWithError() throws {
    let mockURLSession = MockURLSession(statusCode: 200)
    let mock = setMockSession(session: mockURLSession)
    sut = ChatViewModel(networkService: mock)
    input = .init()
    cancellables = .init()
  }
  
  override func tearDownWithError() throws {
    sut = nil
    input = nil
    cancellables = nil
  }
  
  func test_sendButtonTapped_input을_send했을_때_output은_nil이_아니다() {
    // given
    let output = sut.transform(input: input.eraseToAnyPublisher())
    
    output.sink { event in
      switch event {
      case .fetchChatResponseDidFail(_):
        // then
        XCTFail()
      case .fetchChatResponseDidSucceed(let response):
        // then
        XCTAssertNotNil(response)
        print(response)
      case .toggleSendButton(let isEnable):
        // then
        XCTAssertNotNil(isEnable, "\(isEnable)")
      }
    }
    .store(in: &cancellables)
    
    // when
    input.send(
      .sendButtonTapped(
        message: Message(
          role: "user",
          content: "Compose a poem that explains the concept of recursion in programming."
        )
      )
    )
  }
}

extension ChatBotTests: NetworkTestable { }

