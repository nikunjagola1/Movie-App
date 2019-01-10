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
    
    class Genre: Codable{
        var name: String?
    }
}

/*
{
    "id": "c882cac5-e0a1-450a-8d59-9cc29945fc4a",
    "title": "THE TITAN",
    "genre_ids": [
    {
    "id": "2",
    "name": "Adventure"
    },
    {
    "id": "7",
    "name": "Sci-Fi"
    }
    ],
    "age_category": "D",
    "rate": 8.75,
    "release_date": 1543594008,
    "poster_path": "https://i.imgur.com/umvGoMr.jpg",
    "presale_flag": 1,
    "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec"
}
*/
