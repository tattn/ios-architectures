//
//  Presenter.swift
//  ios-architectures
//
//  Created by 田中 達也 on 2016/11/30.
//  Copyright © 2016年 tattn. All rights reserved.
//

import Foundation

struct CatCellData {
    let url: URL?
}

protocol CatPresenter: class {
    func showCats()
}

protocol CatPresenterOutput: class {
    func receive(cats: [CatCellData])
}

class CatPresenterImpl: CatPresenter, CatOutput {
    var interacter: CatInteracter!
    weak var output: CatPresenterOutput?


    func showCats() {
        interacter.getCats()
    }


    func receive(cats: [Cat]) {
        let cats = cats.map { CatCellData(url: URL(string: $0.url)) }
        output?.receive(cats: cats)
    }
}
