//
//  Bundle+.swift
//  ChatBot
//
//  Created by 강창현 on 4/3/24.
//

import Foundation

extension Bundle {
  var chatBotAPIKey: String {
    guard 
      let key = self.object(forInfoDictionaryKey: "ChatBot_API_KEY") as? String
    else {
      return ""
    }
    return key
  }
}
