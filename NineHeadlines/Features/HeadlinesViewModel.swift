//
//  HeadlinesViewModel.swift
//  NineHeadlines
//
//  Created by Yi JIANG on 10/6/19.
//  Copyright © 2019 Siphty Pty Ltd. All rights reserved.
//

import Foundation

class HeadlinesViewModel {
    
    private let store: HeadlinesStore
    private var headlines: [Asset]? 
    
    // MARK: Events
    var updated: (() -> Void)?
    var hasAlertMessage: ((String, Error?) -> Void)?
    
    // MARK: TableView DataSource
    var numberOfRows: Int {
        return store.headlines?.count ?? 0
    }
    
    
    
    // MARK: Funcs
    init(_ store: HeadlinesStore = HeadlinesStore.shared) {
        self.store = store
        store.fetchHeadlines()
        prepareStore()
    }
    
    private func prepareStore() { 
        store.storeUpdated = {[weak self] in
            guard let self = self else { return }
            self.headlines = self.store.headlines
            self.updated?()
        }
        
        store.hasCommonError = { commonError in
            switch commonError {
            case .customError(let message):
                self.hasAlertMessage?(message, nil)
            case .fileError(let message, error: let error):
                guard let message = message else { return }
                self.hasAlertMessage?(message, error)
            case .parsingError(let error):
                self.hasAlertMessage?("JSON Pasing error", error)
            case .urlError:
                self.hasAlertMessage?("URL is invalid", nil)
            }
        }
    }
    
    
    func headline(at row: Int) -> Asset? {
        guard row < store.headlines?.count ?? 0 else { return nil }
        return store.headlines?[row]
    }
    
    func bestThumbnailImageURL(at row: Int) -> URL? {
        guard let relatedImages = store.headlines?[row].relatedImages else { return nil }
        if let thumbnailImage = relatedImages.first(where: {$0.type == .thumbnail}) {
            return thumbnailImage.url
        } else {
            // Comment: If there is no thumbnail image, we are going to find first smallest image
            var images = relatedImages
            images.sort(by: {$0 < $1})
            return images.first?.url
        }
    }  
    
    func refreshHeadlines() {
        store.fetchHeadlines()
    }
}
