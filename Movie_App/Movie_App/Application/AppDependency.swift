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

class AppDependency: HasWindow, HasAPI {
    
    let window: UIWindow
    let api: API
    
    init(window: UIWindow) {
        self.window = window
        self.api = API.shared
    }
}
