//
//  EventsCollectionCell.swift
//  sportsApp
//
//  Created by Malak Samir on 26/09/2023.
//

import UIKit

class EventsCollectionCell: UICollectionViewCell {

    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var team2Label: UILabel!
    @IBOutlet weak var team1Label: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        eventImage.layer.cornerRadius = 25
    }

}
