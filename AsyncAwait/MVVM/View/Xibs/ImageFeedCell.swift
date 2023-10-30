//
//  ImageFeedCell.swift
//  Learning-Examples
//
//  Created by Karthi Rasu on 23/07/23.
//

import UIKit

class ImageFeedCell: UITableViewCell {

    @IBOutlet weak var feedImage : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        feedImage.contentMode = .scaleAspectFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
