//
//  EntryPoint.swift
//  ios-architectures
//
//  Created by 田中 達也 on 2016/12/03.
//  Copyright © 2016年 tattn. All rights reserved.
//

import UIKit

struct EntryPoint {
    func main() -> UIViewController {
        let view       = CatListVC()
        let presenter  = CatPresenterImpl()
        let useCase    = CatUseCaseImpl()
        let repository = CatRepositoryImpl()
        let dataStore  = CatDataStoreImpl()
        
        view.presenter       = presenter
        presenter.view       = view
        presenter.useCase    = useCase
        useCase.repository   = repository
        useCase.output       = presenter
        repository.dataStore = dataStore
        repository.output    = useCase
        dataStore.output     = repository

        return view
    }
}
