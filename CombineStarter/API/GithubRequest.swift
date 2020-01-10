//
//  GithubRequest.swift
//  CombineStarter
//
//  Created by Iichiro Kawashima on 2020/01/11.
//  Copyright © 2020 Iichiro Kawashima. All rights reserved.
//

import Foundation
import Combine

enum APIError: Error {
    case invalidResponse
    case serverErrorMessage(statusCode: Int, data: Data)
    case urlError(URLError)
}

class GithubRequest {

    func send(_ query: String) -> AnyPublisher<Data, APIError> {

        guard var components = URLComponents(string: "https://api.github.com/search/repositories") else {
            return .empty()
        }
        components.queryItems = [URLQueryItem(name: "q", value: query)]

        guard let url = components.url else {
            return .empty()
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError { APIError.urlError($0) }
            .flatMap { data, response -> AnyPublisher<Data, APIError> in
                guard let response = response as? HTTPURLResponse else {
                    return .fail(.invalidResponse)
                }

                guard 200..<300 ~= response.statusCode else {
                    return .fail(.serverErrorMessage(statusCode: response.statusCode,
                                                     data: data))
                }

                return .just(data)
        }
        .eraseToAnyPublisher()
    }
}
