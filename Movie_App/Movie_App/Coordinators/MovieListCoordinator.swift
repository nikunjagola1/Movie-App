//
//  MovieListCoordinator.swift
//  Movie_App
//
//  Created by MAC110 on 1/10/19.
//  Copyright © 2019 MAC110. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

class MovieListCoordinator: Coordinator<Void>{
    
    typealias Dependencies = HasAPI
    private let dependencies: Dependencies
    
    private let navigationController:UINavigationController
    private let searchString: String
    
    init(navigationController:UINavigationController, dependencies: Dependencies, searchString: String) {
        self.navigationController = navigationController
        self.dependencies = dependencies
        self.searchString = searchString
    }
    
    override func start() -> Observable<CoordinationResult> {
        self.showMovieListViewController()
        return Observable.never()
    }
    
    private func showMovieListViewController(){
        let nowShowingViewController = getMovieListViewController(launchOption: .nowShowing)
        let comingSoonViewController = getMovieListViewController(launchOption: .comingSoon)
        let viewModel = MovieListPageContainerViewModel.init(dependencies: dependencies, viewControllers: [nowShowingViewController,comingSoonViewController])
        let viewController = UIStoryboard.main.movieListPageContainerViewController
        viewController.viewModel = viewModel
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    private func getMovieListViewController(launchOption: MovieListViewModel.LaunchOption) -> MovieListViewController{
        let viewModel = MovieListViewModel.init(dependencies: self.dependencies, launchOption: launchOption, searchString: self.searchString)
        let viewController = UIStoryboard.main.movieListViewController
        viewController.viewModel = viewModel
        return viewController
    }
    
    deinit {
        plog(RootCoordinator.self)
    }
}
