//
//  ViewModel.swift
//  ios-architectures
//
//  Created by 田中 達也 on 2016/11/30.
//  Copyright © 2016年 tattn. All rights reserved.
//

import Foundation
import SWXMLHash

protocol CatViewModel: class {
    var count: Int { get }
    subscript (index: Int) -> URL? { get }
    
    func bind(didChange: @escaping () -> Void)
    func reloadData()
}

class CatDefaultViewModel: CatViewModel {

    private var cats: [Cat] = [] {
        didSet {
            didChange?()
        }
    }

    var count: Int {
        return cats.count
    }

    subscript (index: Int) -> URL? {
        return URL(string: cats[index].url)
    }



    private var didChange: (() -> Void)?

    func bind(didChange: @escaping () -> Void) {
        self.didChange = didChange
    }

    func reloadData() {
        guard let url = URL(string: "https://thecatapi.com/api/images/get?format=xml&results_per_page=20&size=small") else {
            return
        }

        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { [weak self] data, _, _ in

            guard let data = data else {
                return
            }

            let xml = SWXMLHash.parse(data)

            self?.cats = xml["response"]["data"]["images"]["image"].all
                .flatMap { (id: $0["id"].element?.text ?? "", url: $0["url"].element?.text ?? "") }
                .map { Cat(id: $0.id, url: $0.url) }

        }.resume()
    }
}
