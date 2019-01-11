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
    
    // Dependencies
    typealias Dependencies = HasAPI
    private let dependencies: Dependencies
    
    //Initial Setup
    enum LaunchOption: String{
        case nowShowing = "nowshowing"
        case comingSoon = "comingsoon"
    }
    private let launchOption: LaunchOption
    private let searchString: String
    
    //DATA
    var movies: BehaviorRelay<[Movie]> = BehaviorRelay(value: [])
    
    //Action Subjects
    var callNextPage = PublishSubject<Void>()
    
    //Pagination
    private var pageNumber: Int = 1
    
    
    init(dependencies: Dependencies,launchOption: LaunchOption,searchString: String){
        self.dependencies = dependencies
        self.launchOption = launchOption
        self.searchString = searchString
        super.init()
        self.callGetMovieListAPI()
        self.callNextPage.asObservable().subscribe(onNext:{[weak self] _ in
            guard let `self` = self else {return}
            self.callGetMovieListAPI()
        }).disposed(by: disposeBag)
    }
}

extension MovieListViewModel{

    func callGetMovieListAPI(){
        let _pageNumber = pageNumber
        self.dependencies.api.searchMovieAPI(keyword: self.searchString,pageNumber: pageNumber,type: launchOption.rawValue)
            .trackActivity(pageNumber == 1 ? isLoading : ActivityIndicator())
            .observeOn(SerialDispatchQueueScheduler(qos: .default))
            .subscribe {[weak self] (event) in
                guard let `self` = self else { return }
                switch event {
                case .next(let result):
                    switch result {
                    case .success(let response):
                        if _pageNumber == 1 {
                            self.movies.accept(response.results)
                        }else{
                            self.movies.accept(self.movies.value + response.results)
                        }
                        self.pageNumber += 1
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
