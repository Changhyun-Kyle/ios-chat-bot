//
//  Usage.swift
//  ChatBot
//
//  Created by 이보한 on 2024/3/27.
//

struct Usage: Codable {
  let promptTokens: Int
  let completionTokens: Int
  let totalTokens: Int
  
  enum CodingKeys: String, CodingKey {
    case promptTokens = "prompt_tokens"
    case completionTokens = "completion_tokens"
    case totalTokens = "total_tokens"
  }
}
