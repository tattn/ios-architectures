//
//  UseCase.swift
//  ios-architectures
//
//  Created by 田中 達也 on 2016/12/01.
//  Copyright © 2016年 tattn. All rights reserved.
//

import Foundation

protocol CatUseCase {
    func loadCats()
}

protocol CatUseCaseOutput: class {
    func receive(cats: [CatCellData])
}

class CatUseCaseImpl: CatUseCase, CatRepositoryOutput {
    var repository: CatRepository?
    weak var output: CatUseCaseOutput?

    func loadCats() {
        repository?.getCats()
    }

    func receive(cats: [Cat]) {
        let models = cats.map { CatCellData(url: URL(string: $0.url)) }
        output?.receive(cats: models)
    }
}
