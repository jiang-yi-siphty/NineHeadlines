//
//  HeadlinesStore.swift
//  NineHeadlines
//
//  Created by Yi JIANG on 10/6/19.
//  Copyright © 2019 Siphty Pty Ltd. All rights reserved.
//

import Foundation

class HeadlinesStore {
    static let shared = HeadlinesStore()
    private let apiClient: ApiClient
    
    // MARK: Data Binding
    var headlines: [Asset]? {
        didSet {
            storeUpdated?()
        }
    }
    var alertMessage: String? {
        didSet {
            guard let message = alertMessage else { return }
            hasCommonError?(.customError(message))
        }
    }
    
    // MARK: Events
    var storeUpdated: (() -> Void)?
    var hasCommonError: ((CommonError) -> Void)?
    
    // MARK: Init
    init(apiClient: ApiClient = ApiClient()) {
//        self.apiClient = apiClient
        self.apiClient = MockApiClient() 
    }
}

// MARK: - API Session Handling
extension HeadlinesStore {
    
    func fetchHeadlines() {
        apiClient.networkRequest(.nineHeadlines) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                guard let data = data else {
                    self.alertMessage = "We run out of headlines..."
                    return 
                }
                do {
                    let decoder = JSONDecoder()
                    do {
                        let responseModel = try decoder.decode(NewsResponse.self, from: data)
                        self.headlines = responseModel.assets
                    } catch {
                        self.alertMessage = error.localizedDescription
                    }
                } catch let error {
                    self.alertMessage = error.localizedDescription
                }
            case .failure(let commonError):
                self.hasCommonError?(commonError)
            }
            
        }
    }
}
