//
//  SearchViewModel.swift
//  Movie_App
//
//  Created by MAC110 on 1/9/19.
//  Copyright © 2019 MAC110. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel: BaseViewModel{
    
    // Dependencies
    typealias Dependencies = HasSearchHistory
    private let dependencies: Dependencies
    
    //Data
    var searchHistory: Observable<[String]>
    var searchString : BehaviorRelay<String>   = BehaviorRelay(value: "")
    
    //Action
    let dismiss = PublishSubject<Void>()
    let searchDidTapped = PublishSubject<Void>()
    let selectedKeyword = PublishSubject<String?>()
    
    init(dependencies: Dependencies){
        self.dependencies = dependencies
        self.searchHistory = dependencies.searchHistory.arrKeyword.asObservable()
        super.init()
        self.searchDidTapped.asObservable().subscribe(onNext: {[weak self] _ in
            guard let `self` = self else {return}
            self.dependencies.searchHistory.insert(self.searchString.value)
        }).disposed(by: self.disposeBag)
    }
    
    func deleteElement(for indexPath: IndexPath){
        if indexPath.row < self.dependencies.searchHistory.arrKeyword.value.count{
            self.dependencies.searchHistory.remove(self.dependencies.searchHistory.arrKeyword.value[indexPath.row])
        }
    }
}
