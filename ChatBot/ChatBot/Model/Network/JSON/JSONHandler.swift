//
//  JSONHandler.swift
//  ChatBot
//
//  Created by 강창현 on 4/3/24.
//

import Foundation

enum JSONHandler {
  private static let encoder = JSONEncoder()
  static let decoder = JSONDecoder()
  
  static func handleEncodedData(data: Encodable) throws -> Data {
    do {
      let encodedData = try encoder.encode(data)
      return encodedData
    } catch {
      throw NetworkError.encodingError
    }
  }
  
  static func handleDecodedData<T: Decodable>(data: Data?) throws -> T {
    guard
      let data = data
    else {
      throw NetworkError.noDataError
    }
    
    do {
      let decodedData = try decoder.decode(T.self, from: data)
      return decodedData
    } catch {
      throw NetworkError.decodingError
    }
  }
  
  static func load(fileName: String) -> Data? {
    let extensionType = "json"
    guard
      let fileLocation = Bundle.main.url(forResource: fileName, withExtension: extensionType)
    else {
      print("Failed to get file location for \(fileName).json")
      return nil
    }
    
    do {
      let data = try Data(contentsOf: fileLocation)
      return data
    } catch {
      print("Failed to load data from \(fileLocation.path): \(error.localizedDescription)")
      return nil
    }
  }
}
