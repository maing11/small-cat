//
//  catViewModel.swift
//  SmallCat
//
//  Created by Mai Nguyen on 11/12/20.
//  Copyright © 2020 Mai Nguyen. All rights reserved.
//

import Foundation
class CatViewModel {
    
    
    let networkService  = NetworkService()
    
    var cats = [Cat]()
    
    func downloadCat(completion: @escaping ([Cat]) -> Void){
        networkService.downloadData(client: CatClient.search) { (mycats: [Cat]) in
            self.cats = mycats
            completion(mycats)
        }
    }
    
    func numberOfCat() -> Int {
        return cats.count
    }
    
    // test
    
    func sum(a: Int, b: Int) -> Int {
        return a + b
    }
}
