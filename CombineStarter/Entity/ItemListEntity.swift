//
//  ItemListEntity.swift
//  CombineStarter
//
//  Created by Iichiro Kawashima on 2020/01/10.
//  Copyright © 2020 Iichiro Kawashima. All rights reserved.
//

import Foundation

struct ItemListEntity<T: Decodable>: Decodable {
    let items: [T]
}
