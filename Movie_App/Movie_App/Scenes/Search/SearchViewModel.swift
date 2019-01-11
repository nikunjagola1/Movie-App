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
    private var arrKeywords  : [String]
    private var filtteredKeywords : BehaviorRelay<[String]> = BehaviorRelay(value: [])
    var searchHistory: Observable<[String]>
    var searchString : BehaviorRelay<String>   = BehaviorRelay(value: "")
    
    
    //Action
    let dismiss = PublishSubject<Void>()
    let searchDidTapped = PublishSubject<Void>()
    let selectedKeyword = PublishSubject<String?>()
    
    init(dependencies: Dependencies){
        self.dependencies = dependencies
        self.arrKeywords = dependencies.searchHistory.arrKeyword.value
        self.filtteredKeywords.accept(dependencies.searchHistory.arrKeyword.value)
        self.searchHistory = filtteredKeywords.asObservable()
        super.init()
        self.searchDidTapped.asObservable().subscribe(onNext: {[weak self] _ in
            guard let `self` = self else {return}
            self.dependencies.searchHistory.insert(self.searchString.value)
        }).disposed(by: self.disposeBag)
        self.searchString.asObservable().subscribe(onNext: { [weak self] _ in
            guard let `self` = self else {return}
            let trimmedString = self.searchString.value.trimmingCharacters(in: .whitespaces).lowercased()
            if trimmedString != ""{
                   let filterArray = self.arrKeywords.filter({$0.lowercased().contains(trimmedString.lowercased())})
                self.filtteredKeywords.accept(filterArray)
            }else{
                self.filtteredKeywords.accept(dependencies.searchHistory.arrKeyword.value)
            }
        }).disposed(by: self.disposeBag)
    }
    
    func deleteElement(for indexPath: IndexPath){
        if indexPath.row < self.dependencies.searchHistory.arrKeyword.value.count{
            self.dependencies.searchHistory.remove(self.dependencies.searchHistory.arrKeyword.value[indexPath.row])
        }
    }
}
