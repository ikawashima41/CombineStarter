//
//  ViewController.swift
//  CombineStarter
//
//  Created by Iichiro Kawashima on 2020/01/10.
//  Copyright © 2020 Iichiro Kawashima. All rights reserved.
//

import UIKit
import Combine

final class ViewController: UIViewController {

    private var cancellableSet: Set<AnyCancellable> = []
    private let repository = GithubRepository()

    override func viewDidLoad() {
        super.viewDidLoad()

        repository.fetch(query: "demo")?
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    print("Finished")
                }
            }, receiveValue: { response in
                print(response)
            })
            .store(in: &cancellableSet)
    }
}
