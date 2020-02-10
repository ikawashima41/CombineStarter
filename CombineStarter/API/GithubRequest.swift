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
    case serverErrorMessage(statusCode: Int)
    case urlError(URLError)
}

final class GithubRequest {

    func build(_ query: String) throws -> URLRequest {

        guard var components = URLComponents(string: "https://api.github.com/search/repositories") else {
            throw APIError.invalidResponse
        }
        components.queryItems = [URLQueryItem(name: "q", value: query)]

        guard let url = components.url else {
            throw APIError.invalidResponse
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        return request
    }

    func fetch(query: String, session: URLSession = URLSession.shared)throws -> URLSession.DataTaskPublisher {
        let request = try build(query)
        return session.dataTaskPublisher(for: request)
    }
}
