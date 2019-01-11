//
//  ViewController.swift
//  Movie_App
//
//  Created by MAC110 on 1/9/19.
//  Copyright © 2019 MAC110. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire
import Alamofire

class API {
    
    static let shared:API = {
        let instance = API()
        return instance
    }()
    
    init() {
        
    }
    
    // Call Get Movie List API
    func getHomeMovieList() -> Observable<APIResult<BaseAPIResponse>> {
        
        return API.handleDataRequest(dataRequest: APIManager.shared.requestObservable(api: APIRouter.homeMovieList)).map({ (response) -> APIResult<BaseAPIResponse> in
            let isSuccessfullTuple = API.isAPISuccessful(response: response)
            if !isSuccessfullTuple.0{
                return APIResult.failure(error: isSuccessfullTuple.1!)
            }
            let apiResponse = BaseAPIResponse(response: response)
            let (apiStatus, _) = (true, APICallError.init(status: .success))
            if apiStatus { return APIResult.success(value: apiResponse) }
        })
    }
    
    func searchMovieAPI(keyword: String,pageNumber: Int,type: String) -> Observable<APIResult<BaseAPIResponse>> {
        return API.handleDataRequest(dataRequest: APIManager.shared.requestObservable(api: APIRouter.searchMovie(keyword: keyword, pageNumber: pageNumber, type: type))).map({ (response) -> APIResult<BaseAPIResponse> in
            let isSuccessfullTuple = API.isAPISuccessful(response: response)
            if !isSuccessfullTuple.0{
                return APIResult.failure(error: isSuccessfullTuple.1!)
            }
            let apiResponse = BaseAPIResponse(response: response)
            let (apiStatus, _) = (true, APICallError.init(status: .success))
            if apiStatus { return APIResult.success(value: apiResponse) }
        })
    }
    
    
    
    
    private static func handleDataRequest(dataRequest: Observable<DataRequest>) -> Observable<[String:Any]?> {

        if NetworkReachabilityManager()!.isReachable == false {
            return Observable<[String: Any]?>.create({ (observer) -> Disposable in
                observer.on(.next(["Error":NSLocalizedString("Unable to contact the server", comment: "") ,
                                   "IsInternetOff":true]))
                observer.on(.completed)
                return Disposables.create()
            })
        }
        
        return Observable<[String: Any]?>.create({ (observer) -> Disposable in
            dataRequest.observeOn(MainScheduler.instance).subscribe({ (event) in
                
                switch event {
                    
                case .next(let e):
                    plog(e.debugDescription)
                    
                    e.responseJSON(completionHandler: { (dataResponse) in
                        
                        switch dataResponse.result {
                            
                        case .success(let data):
                            
                            guard var json = data as? [String:Any] else {
                                observer.onNext(nil)
                                return
                            }
                            json.updateValue(dataResponse.response!.statusCode, forKey: "status")
                            plog(json.keysToCamelCase)
                            
                            guard dataResponse.response!.statusCode == 200  else {
                                observer.onNext(["Error":json.keysToCamelCase["statusMessage"] ?? "",
                                                 "IsInternetOff":false])
                                return
                            }
                            
                            observer.onNext(json.keysToCamelCase)
                            
                        case .failure(let error):
                            plog(error)
                            let errorCode = (error as NSError).code
                            if errorCode == -1005 || errorCode == -1009 {
                                observer.onNext(["Error": NSLocalizedString("Unable to contact the server", comment: ""),
                                                 "IsInternetOff":true])
                            } else {
                                observer.onNext(["Error":error.localizedDescription,
                                                 "IsInternetOff":false])
                            }
                            
                            observer.onCompleted()
                        }
                    })
                    
                case .error(let error):
                    plog(error)
                    observer.onNext(["Error":error.localizedDescription])
                    observer.onNext(nil)
                    
                case .completed:
                    observer.onCompleted()
                }
            })
        })
    }
    private static func isAPISuccessful(response: [String:Any]?) -> (Bool, APICallError?) {
        
        if (response ?? [:]).keys.contains("Error") {
            if (response ?? [:]).keys.contains("IsInternetOff") {
                if let isInternetOff = response!["IsInternetOff"] as? Bool {
                    if isInternetOff {
                        return (false,APICallError(critical: false, code: InternetConnectionErrorCode.offline.rawValue, reason: response!["Error"] as! String, message: response!["Error"] as! String))
                    }
                }
            }
            return (false,APICallError(critical: false, code: 1111, reason: response!["Error"] as! String, message: response!["Error"] as! String))
        }
        return (true,nil)
    }
}

