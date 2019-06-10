//
//  ApiService.swift
//  NineHeadlines
//
//  Created by Yi JIANG on 10/6/19.
//  Copyright © 2019 Siphty Pty Ltd. All rights reserved.
//

import Foundation

enum RequestStatus {
    case success(AnyObject?)
    case fail(RequestError)
}

struct RequestError : LocalizedError {
    var errorDescription: String? { return mMsg }
    var failureReason: String? { return mMsg }
    var recoverySuggestion: String? { return "" }
    var helpAnchor: String? { return "" }
    private var mMsg : String
    
    init(_ description: String) {
        mMsg = description
    }
    
    init(_ error: Error){
        mMsg = error.localizedDescription
    }
}

enum ApiConfig {
    case nineHeadlines
    //We can extend cases to call other service or other API
    
    //NH: Nine Headlines
    fileprivate static let NHBaseUrl = "https://bruce-v2-mob.fairfaxmedia.com.au/"
    
    var apiVersion: String {
        switch self {
        case .nineHeadlines: 
            return "1"
        }
    }
    
    var urlPath: String {
        switch self {
        case .nineHeadlines:
            return "/coding_test/13ZZQX/full"
        }
    }
    
    var method: String {
        switch self {
        case .nineHeadlines:
            return "GET"
        }
    }
    
    var header: [String: Any]?{
        switch self {
        case .nineHeadlines:
            return nil
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .nineHeadlines:
            return nil
        }
    }
    
    func getFullUrl() -> URL {
        var baseUrl: String!
        switch self {
        case .nineHeadlines:
            baseUrl = ApiConfig.NHBaseUrl
        }
        
        if let url = URL(string: baseUrl + apiVersion + self.urlPath)  {
            return url
        } else {
            return URL(string: baseUrl)!
        }
    }
}

protocol ApiService {
    func networkRequest(_ config: ApiConfig, completionHandler: @escaping ((Result<Data?, CommonError>) -> Void))
}

