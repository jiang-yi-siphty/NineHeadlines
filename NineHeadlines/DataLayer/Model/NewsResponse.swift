//
//  NHResponse.swift
//  NineHeadlines
//
//  Created by Yi JIANG on 10/6/19.
//  Copyright © 2019 Siphty Pty Ltd. All rights reserved.
//

import Foundation

// Here, we put all structs in one file, as there is no other data model 
// using any of below struct as common data model.

struct NewsResponse: Codable {
    let id: Int?
    let assets: [Asset]?
    let timeStamp: Date?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        assets = try container.decodeIfPresent([Asset].self, forKey: .assets)
        if let timeStampInterval = try container
            .decodeIfPresent(TimeInterval.self, forKey: .timeStamp) ?? nil {
            timeStamp =  Date(timeIntervalSince1970: timeStampInterval / 1000)
        } else {
            timeStamp = nil
        }
    }
}

struct Asset: Codable {
    let url: URL?
    let timeStamp: Date?
    let headline: String?
    let theAbstract: String?
    let byLine: String?
    let relatedImages: [RelatedImage]?
    let sponsored: Bool?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        url = try container.decodeIfPresent(URL.self, forKey: .url)
        if let timeStampInterval = try container
            .decodeIfPresent(TimeInterval.self, forKey: .timeStamp) ?? nil {
            timeStamp =  Date(timeIntervalSince1970: timeStampInterval / 1000)
        } else {
            timeStamp = nil
        }
        headline = try container.decodeIfPresent(String.self, forKey: .headline)
        theAbstract = try container.decodeIfPresent(String.self, forKey: .theAbstract)
        byLine = try container.decodeIfPresent(String.self, forKey: .byLine)
        relatedImages = try container.decodeIfPresent([RelatedImage].self, forKey: .relatedImages)
        sponsored = try container.decodeIfPresent(Bool.self, forKey: .sponsored)
    }
}

struct RelatedImage: Codable {
    let id: Int?
    let url: URL?
    let type: ImageType?
    let width: Float?
    let height: Float?
    let photographer: String?
    
    // If we adopt Swift 5 and above, we don't need below initialzer: init(from decoder: Decoder).
    // As, the Swift 5 can handle unexpected enum case very well. 
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        url = try container.decodeIfPresent(URL.self, forKey: .url)
        if let imageType = try? container.decodeIfPresent(ImageType.self, forKey: .type) {
        	type = imageType
        } else {
            type = nil
        }
        width = try container.decodeIfPresent(Float.self, forKey: .width)
        height = try container.decodeIfPresent(Float.self, forKey: .height)
        photographer = try container.decodeIfPresent(String.self, forKey: .photographer)
    }
}

enum ImageType: String, Codable {
    case thumbnail
    case afrIndexLead
    case landscape
    case wideLandscape
    case articleLeadNarrow
    case articleLeadWide
    case afrArticleLead
    case afrArticleInline
    
}

extension RelatedImage {
    
    static func < (lhs: RelatedImage, rhs: RelatedImage) -> Bool {
        return lhs.size < rhs.size
    }
    
    var size: Float {
        guard let width = self.width, width != 0, 
            let height = self.height, height != 0 else {
            return Float.greatestFiniteMagnitude
        }
        return width * height
    }
}
