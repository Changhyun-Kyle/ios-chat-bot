//
//  Message.swift
//  ChatBot
//
//  Created by 이보한 on 2024/3/27.
//

struct Message: Codable, Hashable {
  let role: String
  let content: String
}
