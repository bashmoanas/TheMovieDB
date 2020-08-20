//
//  APIRouter.swift
//  TheMovieDB
//
//  Created by Anas Bashandy on 19/8/20.
//  Copyright © 2020 Anas Bashandy. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    case topRatedMovies
    case popularMovies
    case comingSoon
    case nowPlaying
    
    private var parameters: Parameters {
        switch self {
        default: return ["api_key": Constants.apiKey]
        }
    }
    private var path: String {
        switch self {
        case .topRatedMovies: return "/movie/top_rated"
        case .popularMovies: return "/movie/popular"
        case .comingSoon: return "/movie/upcoming"
        case .nowPlaying: return "/movie/now_playing"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        return urlRequest
    }
    func photoAsURLRequest(withSize size: Int, andEndPoint endPoint: String) throws -> URLRequest {
        let url = try Constants.basePhotoURLString.asURL()
        let urlRequest = URLRequest(url: url.appendingPathComponent("\(size)\(endPoint)"))
        return urlRequest
    }
}
