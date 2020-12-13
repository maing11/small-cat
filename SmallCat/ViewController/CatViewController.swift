//
//  CatViewController.swift
//  SmallCat
//
//  Created by Mai Nguyen on 11/12/20.
//  Copyright © 2020 Mai Nguyen. All rights reserved.
//

import UIKit

class CatViewController: UIViewController {
    
    let catViewModel = CatViewModel()
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    
    let collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 30)/2, height: 200)
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myCollectionView.dataSource = self as! UICollectionViewDataSource
        self.myCollectionView.setCollectionViewLayout(collectionViewLayout, animated: true)
        self.myCollectionView.register(UINib(nibName: "CatCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CatCollectionViewCell")
        
        catViewModel.downloadCat { (cats) in
            DispatchQueue.main.async {
                self.myCollectionView.reloadData()
            }
        }
        
    }
}

extension CatViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catViewModel.numberOfCat()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatCollectionViewCell", for: indexPath) as! CatCollectionViewCell
        
        let thisCat = catViewModel.cats[indexPath.row]
        cell.updateCatCell(cat: thisCat)
        return cell
    }
}
