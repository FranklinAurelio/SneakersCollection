//
//  CategoryModel.swift
//  snk_collection
//
//  Created by Franklin Carvalho on 11/09/25.
//

import Foundation
import SwiftData
import SwiftUI

@Model class CategoryModel{
    @Attribute(.unique) var category: String
    var itens: [ItemModel]

    var descriptionDetail: String?
 
    
    init(category: String, itens: [ItemModel], descriptionDetail: String?) {
        self.category = category
        self.itens = itens

        self.descriptionDetail = descriptionDetail
     
    }
}
