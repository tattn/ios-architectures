//
//  EntryPoint.swift
//  ios-architectures
//
//  Created by 田中 達也 on 2016/11/30.
//  Copyright © 2016年 tattn. All rights reserved.
//

import UIKit

struct EntryPoint {
    func main() -> UIViewController {
        let view       = CatListVC()
        let presenter  = CatPresenterImpl()
        let interactor = CatInteractorImpl()
        
        view.presenter       = presenter
        presenter.output     = view
        presenter.interacter = interactor
        interactor.output    = presenter

        return view
    }
}
