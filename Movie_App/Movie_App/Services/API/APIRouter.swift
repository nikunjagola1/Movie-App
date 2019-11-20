//
//  ViewController.swift
//  Movie_App
//
//  Created by MAC110 on 1/9/19.
//  Copyright © 2019 MAC110. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter:URLRequestConvertible {
    
    case homeMovieList
    case searchMovie(keyword: String,pageNumber: Int,type: String)
    
    func asURLRequest() throws -> URLRequest {
        
        var method: HTTPMethod {
            switch self {
            case .homeMovieList,.searchMovie:
                return .get
            }
        }
        
        let params: ([String: Any]?) = {
            switch self {
            case .homeMovieList:
                return nil
            case .searchMovie(let keyword, let pageNumber, let type):
                return ["keyword":keyword,
                        "type": type,
                    "offset": pageNumber
                ]
            }
        }()
        
        let url: URL = {
            
            // Add base url for the request
            let baseURL:String = {
                return "https://easy-mock.com/mock/5c19c6ff64b4573fc81a61f3/movieapp"
            }()

            let relativePath: String? = {
                switch self {
                case .homeMovieList:
                    return "home"
                case .searchMovie:
                    return "loadmore"
                }
            }()
            let urlWithAPIVersion = baseURL
            var url = URL(string: urlWithAPIVersion)!
            if let relativePath = relativePath {
                url = url.appendingPathComponent(relativePath)
            }
            return url
        }()
        
        let encoding:ParameterEncoding = {
            return URLEncoding.default
        }()
        
        let headers:[String:String]? = {
            return nil
        }()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        
        
        return try encoding.encode(urlRequest, with: params)
    }
}
