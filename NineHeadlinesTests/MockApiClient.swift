//
//  MockDataClient.swift
//  NineHeadlinesTests
//
//  Created by Yi JIANG on 10/6/19.
//  Copyright © 2019 Siphty Pty Ltd. All rights reserved.
//

import Foundation

class MockApiClient: ApiClient {
    
    var jsonFileName: MockDataConfig = .responseSuccessWithAssets
    var isNetworkRequestCalled = false
    
    //Use mock json file 
    override func networkRequest(_ config: ApiConfig, 
                        completionHandler: @escaping ((Result<Data?, CommonError>) -> Void))  {
        let config = jsonFileName
        networkRequestByFileNameSession(config, completionHandler: completionHandler)
    }
}

extension MockApiClient {
    
    // If someday we have API server, we can make func networkRequestByNSURLSession() to get data response
    fileprivate func networkRequestByFileNameSession(_ config: MockDataConfig, completionHandler: @escaping ((Result<Data?, CommonError>) -> Void)) {
        completionHandler(JsonFileLoader.loadJson(fileName: config.fileName))
    }
    
}

enum MockDataConfig {
    
    case responseError
    case responseSuccessWithAssets
    case responseSuccessEmptyAsset
    
    var fileName: String {
        switch self {
        case .responseError:
            return "newsResponse_fail"
        case .responseSuccessWithAssets:
            return "newsResponse_success"
        case .responseSuccessEmptyAsset:
            return "newsResponse_empty"
        }
    }
    
}


class JsonFileLoader {
    
    class func loadJson(fileName: String) -> Result<Data?, CommonError> {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                return .success(try NSData(contentsOf: url) as Data)
            } catch let error {
                return .failure(.fileError(fileName, error: error) )
            }
        } else {
            return .failure(.urlError)
        }
    }
    
}
