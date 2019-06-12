//
//  UIImage+AsyncLoading.swift
//  NineHeadlines
//
//  Created by Yi JIANG on 12/6/19.
//  Copyright © 2019 Siphty Pty Ltd. All rights reserved.
//

/*
   Comment: 
   I was overconfident to build this async loading image extension.
   After struggling with image layouts. I decide to 
   adopt Kingfisher pod as async image loading framework.
 */
import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func imageFromURL(_ url: URL, placeHolder: UIImage?) {
        
        image = nil
        if let cachedImage = imageCache.object(forKey: NSString(string: url.absoluteString)) {
            image = cachedImage
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard error == nil else {
                print("LOADING ERROR: \(error.debugDescription)")
                DispatchQueue.main.async { [weak self] in
                    self?.image = placeHolder
                }
                return
            }
            DispatchQueue.main.async { [weak self] in
                guard let data = data  else { return }
                if let downloadedImage = UIImage(data: data) {
                    imageCache.setObject(downloadedImage, 
                                         forKey: NSString(string: url.absoluteString))
                    self?.image = downloadedImage
                    self?.contentMode = .scaleAspectFit
                }
            }
        }).resume()
    }
}
