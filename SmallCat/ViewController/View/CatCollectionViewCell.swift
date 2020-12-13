//
//  CatCollectionViewCell.swift
//  SmallCat
//
//  Created by Mai Nguyen on 11/9/20.
//  Copyright © 2020 Mai Nguyen. All rights reserved.
//

import UIKit

class CatCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var catImage: UIImageView!
    
    @IBOutlet weak var catLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateCatCell(cat: Cat) {
        catLabel.text = cat.id
        self.catImage.downloadImage(urlString: cat.url)
    }

}
