//
//  LatestEventsCollectionViewCell.swift
//  Sports_App
//
//  Created by Malak Samir on 27/09/2023.
//

import UIKit

class LatestEventsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var team1img: UIImageView!
    
    @IBOutlet weak var team2Img: UIImageView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var team2Label: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        img.layer.cornerRadius = 40
        
    }

}
