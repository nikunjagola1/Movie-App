//
//  File.swift
//  Movie_App
//
//  Created by MAC110 on 1/10/19.
//  Copyright © 2019 MAC110. All rights reserved.
//


import Foundation
import RxSwift

final class MovieListPageContainerViewModel: BaseViewModel {
    typealias Dependencies = HasAPI
    // Dependencies
    private let dependencies: Dependencies
    
    var viewControllers: [UIViewController] = []
    
    
    var selectedIndex: Variable<Int> = Variable(0)
    
    init(dependencies: Dependencies,viewControllers: [UIViewController]) {
        self.dependencies = dependencies
        self.viewControllers = viewControllers
        super.init()
    }
}
