//
//  BaseViewModel.swift
//  Movie_App
//
//  Created by MAC110 on 1/9/19.
//  Copyright © 2019 MAC110. All rights reserved.
//

import RxSwift
import RxCocoa

class BaseViewModel {
    
    // Dispose Bag
    let disposeBag = DisposeBag()
    let alertDialog = PublishSubject<(String,String)>()
    let isLoading: ActivityIndicator = ActivityIndicator()
    
    //NavigationBar Actions
    let leftBarButtonDidTapped = PublishSubject<Void>()
    let rightBarButtonDidTapped = PublishSubject<Void>()
}

