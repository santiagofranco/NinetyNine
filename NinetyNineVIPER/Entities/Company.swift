//
//  Company.swift
//  NinetyNineVIPER
//
//  Created by Santi on 20/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation

struct Company: Equatable {
    let id: Int
    let name: String
    let ric: String
    let sharePrice: Double
    var description: String?
    var country: String?
    
    init(id: Int, name: String, ric: String, sharePrice: Double, description: String? = nil, country: String? = nil) {
        self.id = id
        self.name = name
        self.ric = ric
        self.sharePrice = sharePrice
        self.description = description
        self.country = country
    }
    
}
