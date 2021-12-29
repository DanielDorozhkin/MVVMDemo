//
//  NetworkService.swift
//  MVVMDemo
//
//  Created by Daniel Dorozhkin on 28/12/2021.
//

import UIKit
import Alamofire
import EzImageLoader
import EzHTTP

final class NetworkService {
    static let shared = NetworkService()
    
    //MARK: -IMAGE
    func downloadImage(_ completion: @escaping (UIImage) -> Void) {
        let randomInt = Int.random(in: 150...250)
        ImageLoader.get("https://picsum.photos/\(randomInt)", nocache: true) { result in
            if let image = result.image {
                completion(image)
            }
        }
    }
    
    
    
    //MARK: -CITY
    func searchCity(_ text: String, _ completion: @escaping ([CityModel]) -> Void) {
        let url = "https://data.gov.il/api/3/action/datastore_search?resource_id=5c78e9fa-c2e2-4771-93ff-7f400a12f7ba&q=\(text)"
        AF.request(url).response { [weak self] data in
            guard let data = data.data else { return }
            guard let self = self else { return }
            
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(Response.self, from: data)
                
                let citiesResponseArray = model.response.cities
                let citiesArray = self.convertToCityModels(citiesResponseArray)
                
                completion(citiesArray)
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
    }
    
    private func convertToCityModels(_ array: [CityModelResponse]) -> [CityModel] {
        var buffer : [CityModel] = []
        array.forEach {
            buffer.append($0.convertToModel())
        }
        
        return buffer
    }
}
