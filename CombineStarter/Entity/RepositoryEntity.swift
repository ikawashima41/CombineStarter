//
//  RepositoryEntity.swift
//  CombineStarter
//
//  Created by Iichiro Kawashima on 2020/01/10.
//  Copyright © 2020 Iichiro Kawashima. All rights reserved.
//

import Foundation

struct RepositoryEntity: Decodable, Identifiable {
    let id: Int
    let fullName: String
    let description: String?
    let stargazersCount: Int
    let htmlUrl: URL
}
