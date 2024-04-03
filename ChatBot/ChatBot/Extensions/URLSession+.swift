//
//  URLSession+.swift
//  ChatBot
//
//  Created by 강창현 on 4/3/24.
//

import Foundation
import Combine

protocol URLSessionProtocol {
    func dataTaskPublisher(for request: URLRequest) -> AnyPublisher<Data,NetworkError>
    func handleHTTPResponse(data: Data,httpResponse: URLResponse) throws -> Data
}

extension URLSession: URLSessionProtocol {
    func dataTaskPublisher(
        for request: URLRequest
    ) -> AnyPublisher<Data, NetworkError> {
        return self.dataTaskPublisher(for: request)
            .tryMap { (data: Data, response: URLResponse) in
                try self.handleHTTPResponse(data: data, httpResponse: response)
            }
            .mapError { error in
                error as? NetworkError ?? NetworkError.networkError(error)
            }
            .eraseToAnyPublisher()
    }
    
    func handleHTTPResponse(
        data: Data,
        httpResponse: URLResponse
    ) throws -> Data {
        guard let httpResponse = httpResponse as? HTTPURLResponse else {
            throw NetworkError.unknownError
        }
        switch httpResponse.statusCode {
        case 300..<400:
            throw NetworkError.redirectionError
        case 400..<500:
            throw NetworkError.clientError
        case 500..<600:
            throw NetworkError.serverError
        default:
            return data
        }
    }
}