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

class CatPresenterImpl: CatPresenter, CatUseCaseOutput {
    weak var view: CatView?
    var useCase: CatUseCase?


    func showCats() {
        useCase?.loadCats()
    }


    func receive(cats: [CatCellData]) {
        view?.showCats(cats: cats)
    }
}
