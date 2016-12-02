//
//  View.swift
//  ios-architectures
//
//  Created by 田中 達也 on 2016/12/01.
//  Copyright © 2016年 tattn. All rights reserved.
//

import UIKit
import Kingfisher

protocol CatView: class {
    func showCats(cats: [CatCellData])
}

class CatListVC: UIViewController, CatView {

    private lazy var collectionView: UICollectionView = {
        let cellWidth = self.view.frame.width / 3
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0

        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.register(CatListCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        collectionView.refreshControl = refreshControl

        return collectionView
    }()

    var presenter: CatPresenter?

    fileprivate var cats: [CatCellData] = [] {
        didSet {
            collectionView.refreshControl?.endRefreshing()
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Cat List"

        setupUI()
        presenter?.showCats()
    }

    private func setupUI() {
        view.addSubview(collectionView)
    }

    @objc private func pullToRefresh() {
        presenter?.showCats()
    }

    func showCats(cats: [CatCellData]) {
        self.cats = cats
    }
}

extension CatListVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CatListCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: cats[indexPath.row].url)
        
        return cell
    }
}

class CatListCell: UICollectionViewCell {
    
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.frame         = bounds
        imageView.contentMode   = .scaleAspectFill
        imageView.clipsToBounds = true
        addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.kf.cancelDownloadTask()
        imageView.image = nil
    }
    
    func configure(with url: URL?) {
        imageView.kf.setImage(with: url)
    }
}
