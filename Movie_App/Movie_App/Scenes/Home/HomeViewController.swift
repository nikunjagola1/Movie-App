//
//  ViewController.swift
//  Movie_App
//
//  Created by MAC110 on 1/9/19.
//  Copyright © 2019 MAC110. All rights reserved.
//

import UIKit
import FSPagerView
import RxSwift
import RxCocoa

class HomeViewController: BaseViewController {

    var viewModel: HomeViewModel!
    var selectedIndex: Int = 0
    
    @IBOutlet weak private var moviesFSPagerView: FSPagerView!{
        didSet {
            let nibName = UINib(nibName: "HomeMovieCollectionViewCell", bundle:nil)
            self.moviesFSPagerView.register(nibName, forCellWithReuseIdentifier: "HomeMovieCollectionViewCell")
            self.moviesFSPagerView.itemSize = CGSize(width: 270, height: 300)
            self.moviesFSPagerView.isInfinite = true
            self.moviesFSPagerView.interitemSpacing = 0
            self.moviesFSPagerView.contentMode = .scaleAspectFit
            self.moviesFSPagerView.automaticSlidingInterval = 5.0
            let transformer = FSPagerViewTransformer.init(type: .linear)
            transformer.minimumScale = 0.95
            transformer.minimumAlpha = 1.0
            self.moviesFSPagerView.transformer = transformer
        }
    }
    
    @IBOutlet weak private var lblMovieTitle : UILabel!
    @IBOutlet weak private var lblMovieType : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
}

//MARK: - Setup
extension HomeViewController{
    
    private func setup(){
        self.setupUI()
        self.setupBinding(viewModel: self.viewModel)
        viewModel.callHomeMovieListAPI()
    }
    
    private func setupUI(){
        self.configureNavigationWithTitle(title: "Movie", rightButtonImage: UIImage(named: "search"))
    }
    
    private func setupBinding(viewModel: HomeViewModel){
        super.setupBindingForBaseViewModel(viewModel: viewModel)
        self.viewModel.movies.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] _ in
            guard let `self` = self else {return}
            self.moviesFSPagerView.reloadData()
                self.lblMovieTitle.text = self.viewModel.movies.value.first?.title ?? ""
                self.lblMovieType.text = self.viewModel.movies.value.first?.genrnString ?? ""
                self.selectedIndex = 0
        }).disposed(by: disposeBag)
    }
    
}

//MARK: - FSPagerview Delegate
extension HomeViewController: FSPagerViewDelegate, FSPagerViewDataSource{
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return viewModel.movies.value.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "HomeMovieCollectionViewCell", at: index) as! HomeMovieCollectionViewCell
        cell.configure(movie: viewModel.movies.value[index])
        return cell
    }
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        let page = pagerView.currentIndex
        self.lblMovieTitle.text = self.viewModel.movies.value[Int(page)].title ?? ""
        self.lblMovieType.text = self.viewModel.movies.value[Int(page)].genrnString
        pagerView.cellForItem(at: selectedIndex)?.isSelected = false
        self.selectedIndex = page
        pagerView.cellForItem(at: page)?.isSelected = true
    }
    
    func pagerView(_ pagerView: FSPagerView, didEndDisplaying cell: FSPagerViewCell, forItemAt index: Int) {
        cell.isSelected = false
    }
    
}

