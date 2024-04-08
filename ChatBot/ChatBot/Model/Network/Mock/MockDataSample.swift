//
//  MockDataSample.swift
//  ChatBot
//
//  Created by 강창현 on 4/3/24.
//

enum MockDataSample {
  static let requestData = RequestModel(
    messages: [
      Message(
        role: "system",
        content: "You are a poetic assistant, skilled in explaining complex programming concepts with creative flair."
      ),
      Message(
        role: "user",
        content: "Compose a poem that explains the concept of recursion in programming."
      ),
      Message(
        role: "system",
        content: "You are a poetic assistant, skilled in explaining complex programming concepts with creative flair."
      ),
      Message(
        role: "user",
        content: "Compose a poem that explains the concept of recursion in programming."
      ),
      Message(
        role: "system",
        content: "You are a poetic assistant, skilled in explaining complex programming concepts with creative flair."
      ),
      Message(
        role: "user",
        content: "Compose a poem that explains the concept of recursion in programming."
      ),
      Message(
        role: "system",
        content: "You are a poetic assistant, skilled in explaining complex programming concepts with creative flair."
      ),
      Message(
        role: "user",
        content: "Compose a poem that explains the concept of recursion in programming."
      ),
    ]
  )
}
