//
//  Logging.swift
//  Movie_App
//
//  Created by MAC110 on 1/9/19.
//  Copyright © 2019 MAC110. All rights reserved.
//

import Foundation

let isDebug = false

public func plog<T>(_ object: @autoclosure () -> T, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
    if isDebug{
        let value = object()
        let fileURL = URL(fileURLWithPath: file).lastPathComponent
        let queue = Thread.isMainThread ? "UI" : "BG"
        
        print("**************************************************")
        print("<\(queue)> \(fileURL) \(function)[\(line)]: \n" + String(reflecting: value))
        print("**************************************************")
    }
}
