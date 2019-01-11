//
//  Movie.swift
//  Movie_App
//
//  Created by MAC110 on 1/10/19.
//  Copyright © 2019 MAC110. All rights reserved.
//

import Foundation

class Movie: Codable{
    var id: String?
    var title: String?
    var posterPath: String?
    var presaleFlag: Int?
    var description: String?
    var rate: Double?
    var ageCategory: String?
    private var releaseDate: Int?
    private var genreIds: [Genre]?
    
    var genrnString: String{
        guard let gernes = genreIds else {return ""}
        return gernes.map({$0.name ?? ""}).joined(separator: ", ")
    }
    
    var releaseDateString: String{
        let date = Date.init(timeIntervalSince1970: TimeInterval.init(releaseDate ?? 0))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: date)
    }
    
    class Genre: Codable{
        var name: String?
    }
}
