//
//  APIType.swift
//  ChatBot
//
//  Created by 강창현 on 4/3/24.
//

import Foundation

enum APIType {
  case chatbot
  
  var host: String {
    switch self {
    case .chatbot:
      "api.openai.com"
    }
  }
  
  var path: String {
    switch self {
    case .chatbot:
      "/v1/chat/completions"
    }
  }
  
  var header: [String:String] {
    switch self {
    case .chatbot:
      [
        "Content-Type":"application/json",
        "Authorization":Bundle.main.chatBotAPIKey,
      ]
    }
  }
}
