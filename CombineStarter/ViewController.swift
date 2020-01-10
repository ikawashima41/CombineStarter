//
//  ViewController.swift
//  CombineStarter
//
//  Created by Iichiro Kawashima on 2020/01/10.
//  Copyright © 2020 Iichiro Kawashima. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    private let repository = GithubRepository()

    override func viewDidLoad() {
        super.viewDidLoad()

        let result = repository.fetchRepository(query: "i")
        result.sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                print("finished")
            case .failure(let error):
                print("error:\(error.localizedDescription)")
            }
        }) { value in
            print(value)
        }
    }
}
