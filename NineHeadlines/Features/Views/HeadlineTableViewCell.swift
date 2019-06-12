//
//  HeadlineTableViewCell.swift
//  NineHeadlines
//
//  Created by Yi JIANG on 11/6/19.
//  Copyright © 2019 Siphty Pty Ltd. All rights reserved.
//

import UIKit

final class HeadlineTableViewCell: UITableViewCell {
    
    @IBOutlet var contentStackView: UIStackView! {
        didSet {
        }
    }
    
    @IBOutlet var headlineTitleContainerView: UIView!
    @IBOutlet var headlineImageView: UIImageView! {
        didSet {
            guard let image = UIImage(named: "thumbnail") else {
                fatalError("failed to load image of Thumbnail")
            }
            headlineImageView.image = image
        }
    }
    
    @IBOutlet var backgroundGradientView: UIView! {
        didSet {
            backgroundGradientView.backgroundColor = UIColor.black
//            let gradient = CAGradientLayer()
//            gradient.frame = backgroundGradientView.bounds
//            gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
//            gradient.locations = [0, 1]
//            backgroundGradientView.layer.mask = gradient
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
