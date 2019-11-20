//
//  File.swift
//  Movie_App
//
//  Created by MAC110 on 1/9/19.
//  Copyright © 2019 MAC110. All rights reserved.
//
import Foundation

extension Dictionary {
   
    // Underscore Keys to lowerCamelCase keys recursively.
    var keysToCamelCase: Dictionary {
        
        let keys = Array(self.keys)
        let values = Array(self.values)
        var dict: Dictionary = [:]
        
        keys.enumerated().forEach { (index, key) in
            
            var value = values[index]
            var keyCamelCased:Key = key
            
            if let v = value as? Dictionary, let v1 = v.keysToCamelCase as? Value {
                value = v1
            }
            
            if let k = key as? String, let k1 = k.underscoreToCamelCase as? Key {
                keyCamelCased = k1
            }
            
            dict[keyCamelCased] = value
        }
        
        return dict
    }
}
extension String {

    // Underscore string to lowerCamelCase.
    var underscoreToCamelCase: String {
        var items = self.components(separatedBy: "_")
        var camelCase = ""
        let first = items.first?.lowercased() ?? ""
        items.remove(at: 0)
        camelCase = items.reduce(first, {$0 + $1.capitalizingFirstLetter()})
        return camelCase
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
}
