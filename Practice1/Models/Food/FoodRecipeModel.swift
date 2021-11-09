//
//  FoodRecipeModel.swift
//  Practice1
//
//  Created by wooyeong kam on 2021/11/08.
//

import Foundation

struct FoodRecipeModel: Codable {
    let foodName: String
    let partsDetails: [String]
    let titleImage: String
    let menualImage: [String]
    let menualDescription: [String]
}
