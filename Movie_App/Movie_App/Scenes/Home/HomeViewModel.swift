//
//  HomeViewModel.swift
//  Movie_App
//
//  Created by MAC110 on 1/9/19.
//  Copyright © 2019 MAC110. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


class HomeViewModel: BaseViewModel{
    
    // Dependencies
    typealias Dependencies = HasAPI
    private let dependencies: Dependencies
    
    //Data
    var movies: BehaviorRelay<[Movie]> = BehaviorRelay(value: [])

    init(dependencies: Dependencies){
        self.dependencies = dependencies
        super.init()
    }
}

//MARK: API Call
extension HomeViewModel{
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
