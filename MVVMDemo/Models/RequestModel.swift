//
//  RequestModel.swift
//  MVVMDemo
//
//  Created by Daniel Dorozhkin on 27/12/2021.
//

import Foundation

final class RequestModel {
    var requestString : String?
    
    func validateRequest() -> Int? {
        if let text = requestString {
            if let number = Int(text) {
                if number >= 0 {
                    return number
                }
            }
        }
        
        return nil
    }
}
