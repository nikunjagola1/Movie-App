//
//  MovieListViewController.swift
//  Movie_App
//
//  Created by MAC110 on 1/10/19.
//  Copyright © 2019 MAC110. All rights reserved.
//
import UIKit
import RxSwift
import RxCocoa

class MovieListViewController: BaseViewController {

    @IBOutlet weak private var tblMovieList: UITableView!{
        didSet{
            let nibName = UINib(nibName: "MovieListTableViewCell", bundle:nil)
            self.tblMovieList.register(nibName, forCellReuseIdentifier: "MovieListTableViewCell")
            self.tblMovieList.tableFooterView = UIView()
        }
    }

    var viewModel: MovieListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

//MARK: - Setup
extension MovieListViewController{
    private func setup(){
        self.setupUI()
        self.setupBinding(viewModel: self.viewModel)
    }
    private func setupUI(){
        self.tblMovieList.rowHeight = UITableView.automaticDimension
    }
    private func setupBinding(viewModel: MovieListViewModel){
        super.setupBindingForBaseViewModel(viewModel: viewModel)
        viewModel.movies.asObservable()
            .bind(to: tblMovieList.rx.items(cellIdentifier: "MovieListTableViewCell", cellType: MovieListTableViewCell.self)) { (row, element, cell) in
                cell.configure(movie: element)
            }
            .disposed(by: disposeBag)
    }
}





