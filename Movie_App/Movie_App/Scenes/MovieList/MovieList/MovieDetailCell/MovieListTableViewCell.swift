//
//  MovieListTableViewCell.swift
//  Movie_App
//
//  Created by MAC110 on 1/10/19.
//  Copyright © 2019 MAC110. All rights reserved.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {

    @IBOutlet private weak var imvPoster : UIImageView!
    @IBOutlet private weak var lblTitle  : UILabel!
    @IBOutlet private weak var lblRating : UILabel!
    @IBOutlet private weak var lblCertifiicate : UILabel!
    @IBOutlet private weak var lblReleaseDate : UILabel!
    @IBOutlet private weak var lblInfo   : UILabel!
    @IBOutlet weak var vwRating: FloatRatingView!
    
    func configure(movie: Movie){
        self.imvPoster.downloadImageWithCaching(with: movie.posterPath ?? "")
        self.lblTitle.text = movie.title ?? ""
        self.lblRating.text = String(format: "%.2f", movie.rate ?? 0.0)
        self.lblCertifiicate.text = movie.ageCategory ?? ""
        self.lblInfo.text = movie.description ?? ""
        self.lblReleaseDate.text = movie.releaseDateString
        self.vwRating.rating = (movie.rate ?? 1.0) / 2
    }
    
}
