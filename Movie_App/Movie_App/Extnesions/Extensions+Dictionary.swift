//
//  File.swift
//  Movie_App
//
//  Created by MAC110 on 1/9/19.
//  Copyright © 2019 MAC110. All rights reserved.
//
import Foundation

extension Dictionary {
    // Tested against ["ab_dsfdsac_dsd_f":"ab_dsfdsac_dsd_f", "__abc_a":"__abc_a", "abc":["ab_dsfdsac_dsd_f":"ab_dsfdsac_dsd_f", "__abc_a":"__abc_a", "ABc_def_De":1, "bc_def_De":UIColor.blue]]
    
    /// Underscore Keys to lowerCamelCase keys recursively.
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
    
    // Tested against ["ab_dsfdsac_dsd_f", nil, "_", "__abc_a", "Ac_C", "abc", "abc_", "_abc", "", "Abc_def_De", "ABc_def_De", "ABC_def_De", "bc_def_De", "ADay", "aDay", "a_Day", "A_Day"]
    
    /// Underscore string to lowerCamelCase.
    var underscoreToCamelCase: String {
        
        let underscore = CharacterSet(charactersIn: "_")
        var items: [String] = self.components(separatedBy: underscore)
        
        var start: String = items.first ?? ""
        let first = String(start.characters.prefix(1)).lowercased()
        let other = String(start.characters.dropFirst())
        start =  first + other
        
        items.remove(at: 0)
        
        let camelCased: String =  items.reduce(start) { (result, i) -> String in
            result + i.capitalized
        }
        
        return camelCased
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
}
