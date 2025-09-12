//
//  SnkModel.swift
//  snk_collection
//
//  Created by Franklin Carvalho on 21/06/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model class ItemModel{
    @Attribute(.unique) var model: String
    var price: Double
    var size: Int
    var descriptionDetail: String
    var photo: Data?
    var brand: String
    var category: String
    
    init(model: String, price: Double, size: Int, descriptionDetail: String, photo: Data? = nil, brand: String, category: String) {
        self.model = model
        self.price = price
        self.size = size
        self.descriptionDetail = descriptionDetail
        self.photo = photo
        self.brand = brand
        self.category = category
    }
}
