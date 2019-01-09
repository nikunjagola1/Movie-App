//
//  HomeMovieCollectionViewCell.swift
//  Movie_App
//
//  Created by MAC110 on 1/9/19.
//  Copyright © 2019 MAC110. All rights reserved.
//

import UIKit
import FSPagerView
class HomeMovieCollectionViewCell: FSPagerViewCell {

    @IBOutlet weak private var lblPreSale    : UILabel!
    @IBOutlet weak private var vwBuyTicket   : UIView!
    @IBOutlet weak private var imgVwPoster   : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(movie: Movie){
        self.imgVwPoster.downloadImageWithCaching(with: movie.posterPath ?? "")
        self.lblPreSale.isHidden = !(movie.presaleFlag ?? 0 == 1)
    }
    
}
