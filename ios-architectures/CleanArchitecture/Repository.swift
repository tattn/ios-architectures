//
//  Repository.swift
//  ios-architectures
//
//  Created by 田中 達也 on 2016/12/01.
//  Copyright © 2016年 tattn. All rights reserved.
//

import Foundation

protocol CatRepository {
    func getCats()
}

protocol CatRepositoryOutput: class {
    func receive(cats: [Cat])
}

class CatRepositoryImpl: CatRepository, CatDataStoreOutput {
    var dataStore: CatDataStore!
    weak var output: CatRepositoryOutput?

    func getCats() {
        dataStore.getCats()
    }

    
    func receive(cats: [Cat]) {
        output?.receive(cats: cats)
    }
}
