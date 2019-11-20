//
//  AppCoordinator.swift
//  Movie_App
//
//  Created by MAC110 on 1/9/19.
//  Copyright © 2019 MAC110. All rights reserved.
//

import UIKit
import RxSwift

final class AppCoordinator: Coordinator<Void> {
    
    private let navigationController:UINavigationController
    private let window: UIWindow
    let dependencies: AppDependency
    
    init(window:UIWindow, navigationController:UINavigationController) {
        self.window = window
        self.navigationController = navigationController
        self.dependencies = AppDependency(window: self.window)
    }
    
    override func start() -> Observable<Void> {
        return setupRootNavigation()
    }
    
    private func setupRootNavigation() -> Observable<Void> {
        let rootCoordinator = RootCoordinator(navigationController: navigationController, dependencies: self.dependencies)
        return coordinate(to: rootCoordinator)
    }
    
    deinit {
        plog(AppCoordinator.self)
    }
    
}
