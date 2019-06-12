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
  
    @IBOutlet var headlineImageView: UIImageView! {
        didSet {
            guard let image = UIImage(named: "thumbnail") else {
                fatalError("failed to load image of Thumbnail")
            }
            headlineImageView.image = image
        }
    }
  @IBOutlet var headlineTitleLabel: UILabel!
  
  @IBOutlet var headlineByLineLabel: UILabel!
  
  @IBOutlet var headlineDateTimeLabel: UILabel!

  @IBOutlet var headlineSponsoredLabel: UILabel!
  
  @IBOutlet var titleBackgroundView: UIView! {
    didSet {
      titleBackgroundView.backgroundColor = UIColor.black
      let gradient = CAGradientLayer()
      gradient.frame = titleBackgroundView.bounds
      gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
      gradient.locations = [0, 1]
      titleBackgroundView.layer.mask = gradient
    }
  }
  @IBOutlet var headlineAbstractTextView: UITextView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
