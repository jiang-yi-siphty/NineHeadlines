//
//  DataClient.swift
//  NineHeadlines
//
//  Created by Yi JIANG on 10/6/19.
//  Copyright © 2019 Siphty Pty Ltd. All rights reserved.
//

import Foundation

class ApiClient: ApiService {
    
    func networkRequest(_ config: ApiConfig, 
                        completionHandler: @escaping ((Result<Data?, CommonError>) -> Void)) {
        networkRequestByNSURLSession(config, completionHandler: completionHandler)
    }
    
}

extension ApiClient {
    
    /* Comment: 
     	We can use any of other network SDK to replace this , such as Alamofire 
     	or old NSURLConnection or AFNetworking
	 */
    fileprivate func networkRequestByNSURLSession(_ config: ApiConfig, 
                                                  completionHandler: @escaping ((Result<Data?, CommonError>) -> Void)) {
        URLCache.shared.removeAllCachedResponses()
        let url = config.getFullUrl()
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            let result: Result<Data?, CommonError>
            if error != nil {
                result = .failure(.urlError)
            } else {
                result = .success(data)
            }
            completionHandler(result)
        }
        task.resume()
    }
    
}

/* Comment: 
 	Because I can't use Swift 5's new feature, I replicate the Swift 5's Result
 	type.
 */
enum Result<Success, Failure> where Failure : Error {
    
    /// A success, storing a `Success` value.
    case success(Success)
    
    /// A failure, storing a `Failure` value.
    case failure(Failure) 
    
}

/* Comment: 
 	We can extend CommonError case for new errors in the future develpment.
 */
enum CommonError: Error {
    case fileError(_ jsonFileName: String?, error: Error)
    case customError(_ errorMessage: String)
    case parsingError(_ error: Error)
    case urlError
    
    var description: String {
        switch self {
        case .fileError(let fileName, _):
            if let fileName = fileName {
                return "Generic Error with file \(fileName)"
            } else {
                return "Generic Error"
            }
        case .customError(let errorMessage):
            return errorMessage
        case .parsingError(_):
            return "Parsing Error!! Unable to parse the json data"
        case .urlError:
            return "Invalid path url."
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .fileError(let fileName, let error):
            if let fileName = fileName {
                return "Opening \(fileName).json get generic error: \(error.localizedDescription)"
            } else {
                return "\(error.localizedDescription)"
            }
        case .customError(_):
            return nil
        case .parsingError(let error):
            return "Parsing the json data has the issue: \(error.localizedDescription)"
        case .urlError:
            return "Please check: Is the file in the project bundle? Is the URL has correct format? "
        }
    }
    
}
