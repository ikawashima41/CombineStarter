//
//  Combine+Extension.swift
//  CombineStarter
//
//  Created by Iichiro Kawashima on 2020/01/11.
//  Copyright © 2020 Iichiro Kawashima. All rights reserved.
//

import Foundation
import Combine

extension Publisher {

    static func empty() -> AnyPublisher<Output, Failure> {
        return Empty()
            .eraseToAnyPublisher()
    }

    static func just(_ output: Output) -> AnyPublisher<Output, Failure> {
        return Just(output)
            .catch { _ in AnyPublisher<Output, Failure>.empty() }
            .eraseToAnyPublisher()
    }

    static func fail(_ error: Failure) -> AnyPublisher<Output, Failure> {
        return Fail(error: error)
            .eraseToAnyPublisher()
    }
}
