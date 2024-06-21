//
//  SnkModel.swift
//  snk_collection
//
//  Created by Franklin Carvalho on 21/06/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model class Sneaker{
    @Attribute(.unique) var model: String
    var price: Double
    var size: Int
    var descriptionDetail: String
    var photo: Date?
    
    init(model: String, price: Double, size: Int, descriptionDetail: String, photo: Date? = nil) {
        self.model = model
        self.price = price
        self.size = size
        self.descriptionDetail = descriptionDetail
        self.photo = photo
    }
}
