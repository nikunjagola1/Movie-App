//
//  SearchHistory.swift
//  Movie_App
//
//  Created by MAC110 on 1/9/19.
//  Copyright © 2019 MAC110. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SearchHistory{
    
    var arrKeyword: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    
    init() {
        self.read()
    }
    
    private func read(){
        let keywords = UserDefaults.standard.string(forKey: "kSearchHistory") ?? ""
        let _arrKeyword = keywords.components(separatedBy: ",")
        self.arrKeyword.accept(_arrKeyword)
    }
    
    private func store(){
        UserDefaults.standard.set(arrKeyword.value.joined(separator: ","), forKey: "kSearchHistory")
        UserDefaults.standard.synchronize()
    }
    
    func insert(_ keyword: String){
        
        var _arrKeywords = self.arrKeyword.value
        if _arrKeywords.contains(keyword){
            _arrKeywords = _arrKeywords.filter({$0 != keyword})
        }
        _arrKeywords.insert(keyword, at: 0)
        self.arrKeyword.accept(Array(_arrKeywords.prefix(10)))
        self.store()
    }
    
    func remove(_ keyword: String){
        let _arrKeyword = self.arrKeyword.value
        self.arrKeyword.accept(_arrKeyword.filter({$0 != keyword}))
        self.store()
    }
}
