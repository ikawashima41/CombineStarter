//
//  GithubRepository.swift
//  CombineStarter
//
//  Created by Iichiro Kawashima on 2020/01/10.
//  Copyright © 2020 Iichiro Kawashima. All rights reserved.
//

import Foundation
import Combine

protocol GithubRepositoryProtocol {
    func fetchRepository(query: String) -> AnyPublisher<Result<[RepositoryEntity], ErrorEntity>, Never>
}

final class GithubRepository: GithubRepositoryProtocol {

    private let request = GithubRequest()

    func fetchRepository(query: String) -> AnyPublisher<Result<[RepositoryEntity], ErrorEntity>, Never> {

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        return request.send(query)
        .decode(type: ItemListEntity<RepositoryEntity>.self, decoder: decoder)
        .map { Result<[RepositoryEntity], ErrorEntity>.success($0.items) }
        .catch { error -> AnyPublisher<Result<[RepositoryEntity], ErrorEntity>, Never> in
            guard case let .serverErrorMessage(_, data)? = error as? APIError else {
                return .just(.success([]))
            }
            do {
                let response = try JSONDecoder().decode(ErrorEntity.self, from: data)
                return .just(.failure(response))
            } catch _ {
                return .just(.success([]))
            }
        }
        .eraseToAnyPublisher()
    }
}
