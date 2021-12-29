//
//  CityModel.swift
//  MVVMDemo
//
//  Created by Daniel Dorozhkin on 28/12/2021.
//

import Foundation

struct Response: Decodable {
    var response : CitiesSourceResponse
    
    enum CodingKeys: String, CodingKey {
        case response = "result"
    }
}

struct CitiesSourceResponse: Decodable {
    var cities : [CityModelResponse] = []
    
    enum CodingKeys: String, CodingKey {
        case cities = "records"
    }
}

struct CityModelResponse: Decodable {
    let name : String
    
    enum CodingKeys: String, CodingKey {
        case name = "שם_ישוב"
    }
    
    func convertToModel() -> CityModel {
        let model = CityModel(name)
        return model
    }
}
