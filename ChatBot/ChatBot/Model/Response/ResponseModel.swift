//
//  ResponseModel.swift
//  ChatBot
//
//  Created by 이보한 on 2024/3/27.
//

struct ResponseModel: Codable {
  let id: String
  let object: String
  let created: Int
  let model: String
  let choices: [Choice]
  let usage: Usage
  let systemFingerprint: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case object
    case created
    case model
    case choices
    case usage
    case systemFingerprint = "system_fingerprint"
  }
}
