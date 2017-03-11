//
//  Presenter.swift
//  ios-architectures
//
//  Created by 田中 達也 on 2016/12/01.
//  Copyright © 2016年 tattn. All rights reserved.
//

import Foundation

protocol CatPresenter: class {
    func showCats()
}

protocol CatPresenterOutput: class {
    func receive(cats: [CatCellData])
}

class CatPresenterImpl: CatPresenter, CatUseCaseOutput {
    var useCase: CatUseCase!
    weak var output: CatPresenterOutput?


    func showCats() {
        useCase.loadCats()
    }


    func receive(cats: [CatCellData]) {
        output?.receive(cats: cats)
    }
}
