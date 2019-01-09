//
//  File.swift
//  Movie_App
//
//  Created by MAC110 on 1/9/19.
//  Copyright © 2019 MAC110. All rights reserved.
//

import Foundation
import RxSwift
import UIKit
import RxCocoa

class RootCoordinator: Coordinator<Void>{
    typealias Dependencies = HasWindow & HasAPI
    
    private let navigationController:UINavigationController
    private let dependencies: Dependencies
    
    init(navigationController:UINavigationController, dependencies: Dependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    override func start() -> Observable<CoordinationResult> {
        self.showHomeViewController()
        return Observable.never()
    }
    
    private func showHomeViewController(){
        let viewModel = HomeViewModel.init(dependencies: self.dependencies)
        let viewController = UIStoryboard.main.homeViewController
        viewController.viewModel = viewModel
        
        viewModel.rightBarButtonDidTapped.asObservable()
            .subscribe(onNext: {[weak self] _ in
                guard let `self` = self else {return}
                self.showSearchScreen()
            }).disposed(by: disposeBag)
        
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    private func showSearchScreen(){
        self.navigationController.pushViewController(UIViewController(), animated: true)
    }
    
    
   
    
    deinit {
        plog(RootCoordinator.self)
    }
}
