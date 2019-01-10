//
//  MovieListViewModel.swift
//  Movie_App
//
//  Created by MAC110 on 1/10/19.
//  Copyright © 2019 MAC110. All rights reserved.
//
import Foundation
import RxSwift
import RxCocoa

final class MovieListViewModel: BaseViewModel {
    typealias Dependencies = HasAPI
    // Dependencies
    private let dependencies: Dependencies
    
    enum LaunchOption{
        case nowShowing
        case comingSoon
    }
    private let launchOption: LaunchOption
    private let searchString: String
    
    var movies: BehaviorRelay<[Movie]> = BehaviorRelay(value: [])
    
    init(dependencies: Dependencies,launchOption: LaunchOption,searchString: String){
        self.dependencies = dependencies
        self.launchOption = launchOption
        self.searchString = searchString
        super.init()
        self.callHomeMovieListAPI()
    }
}
extension MovieListViewModel{
    func callHomeMovieListAPI(){
        self.dependencies.api.getHomeMovieList()
            .trackActivity(isLoading)
            .observeOn(SerialDispatchQueueScheduler(qos: .default))
            .subscribe {[weak self] (event) in
                guard let `self` = self else { return }
                switch event {
                case .next(let result):
                    switch result {
                    case .success(let response):
                        self.movies.accept(response.results)
                    case .failure(let error):
                        if error.code == InternetConnectionErrorCode.offline.rawValue {
                            self.alertDialog.onNext((NSLocalizedString("Network error", comment: ""), error.message))
                        } else {
                            self.alertDialog.onNext(("Error", error.message))
                        }
                    }
                default:
                    break
                }
            }.disposed(by: disposeBag)
    }
}
