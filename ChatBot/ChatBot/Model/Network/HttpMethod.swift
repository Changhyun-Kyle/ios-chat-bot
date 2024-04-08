//
//  HttpMethod.swift
//  ChatBot
//
//  Created by 강창현 on 4/3/24.
//

enum HttpMethod<T: Encodable> {
  case GET
  case POST(body: T)
  case PUT(body: T)
  case PATCH(body: T)
  case DELETE(body: T)
  
  var configuration: HttpMethodConfiguration<T> {
    switch self {
    case .GET:
      return HttpMethodConfiguration(method: .get, body: nil)
    case .POST(let body):
      return HttpMethodConfiguration(method: .post, body: body)
    case .PUT(let body):
      return HttpMethodConfiguration(method: .put, body: body)
    case .PATCH(let body):
      return HttpMethodConfiguration(method: .patch, body: body)
    case .DELETE(let body):
      return HttpMethodConfiguration(method: .delete, body: body)
    }
  }
}

enum HttpMethodType: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case patch = "PATCH"
  case delete = "DELETE"
  
  var type: String {
    return self.rawValue
  }
}

struct HttpMethodConfiguration<T: Encodable> {
  let method: HttpMethodType
  let body: T?
}

extension HttpMethod {
  var method: HttpMethodType {
    switch self {
    case .GET:
      return .get
    case .POST:
      return .post
    case .PUT:
      return .put
    case .PATCH:
      return .patch
    case .DELETE:
      return .delete
    }
  }
}
