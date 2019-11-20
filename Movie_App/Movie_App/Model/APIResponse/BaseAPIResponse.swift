//
//  BaseAPIResponse.swift
//  Movie_App
//
//  Created by MAC110 on 1/9/19.
//  Copyright © 2019 MAC110. All rights reserved.
//

import Foundation

class BaseAPIResponse: Codable{
    var success: Bool?
    var results: [Movie] = []
    init(response: [String:Any]?){
        guard let response = response else {return}
        
        if let success = response["success"] as? Bool{
            self.success = success
        }
        
        if let results = response["results"] as? [[String: Any]]{
            for result in results{
                if let movieData = try? JSONSerialization.data(withJSONObject: result.keysToCamelCase, options: []) {
                    do {
                        if let movie = try? JSONDecoder().decode(Movie.self, from: movieData) {
                            self.results.append(movie)
                        }
                    }
                }
            }
        }
    }
}



