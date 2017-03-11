//
//  CatCollectionViewLayout.swift
//  ios-architectures
//
//  Created by Tatsuya Tanaka on 2017/03/11.
//  Copyright © 2017年 tattn. All rights reserved.
//

import UIKit

class CatCollectionViewLayout: UICollectionViewFlowLayout {
    convenience init(itemSize: CGFloat) {
        self.init()
        self.itemSize = CGSize(width: itemSize, height: itemSize)
        sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
    }
}
