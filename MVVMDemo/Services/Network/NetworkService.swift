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
    func downloadImage(_ completion: @escaping (UIImage?) -> Void) {
        let randomInt = Int.random(in: 150...250)
        ImageLoader.get("https://picsum.photos/\(randomInt)", nocache: true) { result in
            if let image = result.image {
                completion(image)
            } else {
                completion(nil)
            }
        }
    }
    
    
    
    //MARK: -CITY
    func searchCity(_ text: String, _ completion: @escaping ([CityModel]?) -> Void) {
        guard let url = configureUrlForSearch(text) else {
            completion(nil)
            return
        }
        
        AF.request(url).response { [weak self] data in
            guard let self = self else { return }
            guard let data = data.data else {
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(Response.self, from: data)
                
                let citiesResponseArray = model.response.cities
                let citiesArray = self.convertToCityModels(citiesResponseArray)
                
                if citiesArray.count > 0 {
                    completion(citiesArray)
                } else {
                    completion(nil)
                }
            } catch {
                completion(nil)
            }
        }
    }
    
    private func configureUrlForSearch(_ text: String) -> URL? {
        var urlComponents = URLComponents()
        let resourseId = "5c78e9fa-c2e2-4771-93ff-7f400a12f7ba"
        
        urlComponents.scheme = "https"
        urlComponents.host = "data.gov.il"
        urlComponents.path = "/api/3/action/datastore_search"
        urlComponents.queryItems = [
           URLQueryItem(name: "resource_id", value: resourseId),
           URLQueryItem(name: "q", value: text)
        ]
        
        return urlComponents.url
    }
    
    private func convertToCityModels(_ array: [CityModelResponse]) -> [CityModel] {
        var buffer : [CityModel] = []
        array.forEach {
            buffer.append($0.convertToModel())
        }
        
        return buffer
    }
}
