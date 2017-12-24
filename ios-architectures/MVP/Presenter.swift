//
//  Presenter.swift
//  ios-architectures
//
//  Created by 田中 達也 on 2016/11/30.
//  Copyright © 2016年 tattn. All rights reserved.
//

import Foundation
import SWXMLHash

protocol CatPresenter: class {
    init(view: CatView)

    var numberOfCats: Int { get }
    func imageUrl(index: Int) -> URL?
    func showCats()
}

class CatPresenterImpl: CatPresenter {
    private let view: CatView
    private var cats: [Cat] = []
    
    required init(view: CatView) {
        self.view = view
    }


    
    var numberOfCats: Int {
        return cats.count
    }

    func imageUrl(index: Int) -> URL? {
        return URL(string: cats[index].url)
    }
    
    func showCats() {
        guard let url = URL(string: "http://thecatapi.com/api/images/get?format=xml&results_per_page=20&size=small") else {
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

            DispatchQueue.main.async {
                self?.view.reloadData()
            }

        }.resume()
    }
}
