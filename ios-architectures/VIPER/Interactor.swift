//
//  Interactor.swift
//  ios-architectures
//
//  Created by 田中 達也 on 2016/11/30.
//  Copyright © 2016年 tattn. All rights reserved.
//

import Foundation
import SWXMLHash

protocol CatInteracter {
    func getCats()
}

protocol CatOutput: class {
    func receive(cats: [Cat])
}

class CatInteractorImpl: CatInteracter {
    weak var output: CatOutput?
    
    func getCats() {
        guard let url = URL(string: "https://thecatapi.com/api/images/get?format=xml&results_per_page=20&size=small") else {
            return
        }

        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { [weak self] data, _, _ in

            guard let data = data else {
                return
            }

            let xml = SWXMLHash.parse(data)

            let cats: [Cat] = xml["response"]["data"]["images"]["image"].all
                .flatMap { (id: $0["id"].element?.text ?? "", url: $0["url"].element?.text ?? "") }
                .map { Cat(id: $0.id, url: $0.url) }

            self?.output?.receive(cats: cats)
            
        }.resume()
    }
}
