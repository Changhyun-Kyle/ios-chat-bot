//
//  NetworkError.swift
//  ChatBot
//
//  Created by 강창현 on 4/3/24.
//

import Foundation

enum NetworkError: LocalizedError {
  case invalidURLError
  case noDataError
  case requestFailError
  case redirectionError
  case clientError
  case serverError
  case decodingError
  case encodingError
  case networkError(Error)
  case unknownError
  
  var errorDescription: String? {
    switch self {
    case .invalidURLError:
      return "잘못된 URL 주소입니다."
    case .noDataError:
      return "데이터가 존재하지 않습니다."
    case .requestFailError:
      return "요청에 실패 했습니다."
    case .redirectionError:
      return "리다이렉션 에러 발생"
    case .clientError:
      return "사용자 요청 에러 발생"
    case .serverError:
      return "서버 에러 발생"
    case .decodingError:
      return "JSON 디코딩 에러 발생"
    case .encodingError:
      return "JSON 인코딩 에러 발생"
    case .networkError(let error):
      return "네트워크 에러 발생: \(error)"
    case .unknownError:
      return "알 수 없는 에러 발생"
    }
  }
}
