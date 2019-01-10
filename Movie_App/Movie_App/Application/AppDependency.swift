//
//  AppDependency.swift
//  Movie_App
//
//  Created by MAC110 on 1/9/19.
//  Copyright © 2019 MAC110. All rights reserved.
//

import Foundation
import UIKit


protocol HasWindow {
    var window: UIWindow { get }
}

protocol HasAPI {
    var api: API { get }
}

protocol HasSearchHistory {
    var searchHistory: SearchHistory { get }
}

class AppDependency: HasWindow, HasAPI, HasSearchHistory {
    
    let window: UIWindow
    let api: API
    let searchHistory: SearchHistory
    
    init(window: UIWindow) {
        self.window = window
        self.api = API.shared
        self.searchHistory = SearchHistory()
    }
}
