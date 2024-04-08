//
//  RequestModel.swift
//  ChatBot
//
//  Created by 이보한 on 2024/3/27.
//

struct RequestModel: Codable, Hashable {
  var model: String = "gpt-3.5-turbo-1106"
  var stream: Bool = false
  var messages: [Message]
}
