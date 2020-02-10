//
//  GithubRepository.swift
//  CombineStarter
//
//  Created by Iichiro Kawashima on 2020/01/10.
//  Copyright © 2020 Iichiro Kawashima. All rights reserved.
//

import Foundation
import Combine

//protocol GithubRepositoryProtocol {
//    func fetchRepository(query: String) -> AnyPublisher<Result<[RepositoryEntity], ErrorEntity>, Never>
//}

struct GithubRepository {
    func fetch(query: String) -> AnyPublisher<ItemListEntity<RepositoryEntity>, Error>? {
        return try? GithubRequest().fetch(query: query)
                .tryMap{ try self.validate($0.data, $0.response) }
                .decode(type: ItemListEntity<RepositoryEntity>.self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
    }

    private func validate(_ data: Data, _ response: URLResponse) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw APIError.serverErrorMessage(statusCode: httpResponse.statusCode)
        }
        return data
    }
}
