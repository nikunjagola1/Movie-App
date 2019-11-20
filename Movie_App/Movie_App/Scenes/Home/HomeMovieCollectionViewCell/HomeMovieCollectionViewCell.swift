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
    @IBOutlet weak var buyTktBottomConstraint: NSLayoutConstraint!
    
    override var isSelected: Bool{
        didSet{
            if isSelected{
                let oldFrame = vwBuyTicket.frame
                var newFrame = oldFrame
                newFrame.origin.y = newFrame.origin.y + 40
                self.vwBuyTicket.frame = newFrame
                self.vwBuyTicket.isHidden = false
                UIView.animate(withDuration: 1, animations: {
                    self.vwBuyTicket.frame = oldFrame
                }) { (status) in
                    self.vwBuyTicket.layoutIfNeeded()
                }
            }else{
                vwBuyTicket.isHidden = true
            }
        }
    }

    func configure(movie: Movie){
        vwBuyTicket.isHidden = true
        self.contentView.layer.shadowColor = UIColor.clear.cgColor
        self.imgVwPoster.downloadImageWithCaching(with: movie.posterPath ?? "",placeholderImage: UIImage(named: "video-placeholder"))
        self.lblPreSale.isHidden = !(movie.presaleFlag ?? 0 == 1)
    }
    
}
