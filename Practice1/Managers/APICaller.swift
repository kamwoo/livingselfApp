//
//  AuthManager.swift
//  Practice1
//
//  Created by wooyeong kam on 2021/10/23.
//

import Foundation
import Alamofire
import SwiftyJSON

struct RecipeContants {
    static let FoodBaseURL = "https://openapi.foodsafetykorea.go.kr/api"
    static let cerKey = "/62e41f38294c43ca9ce6"
    static let serviceName = "COOKRCP01"
}

class APICaller{
    static let shared = APICaller()
    
    private init(){}
    
    func getRecipe(){
        let url = RecipeContants.FoodBaseURL + "/sample/COOKRCP01/json/1/5"
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
            .validate(statusCode: 200..<300)
            .responseJSON{ response in
                guard let responseValue = response.value else {return}
                let responseJson = JSON(responseValue)
//                let jsonArray = responseJson[RecipeContants.serviceName]
//                var recipes = [FoodRecipeModel]()
                print(responseJson)
            }
    }
    
}
