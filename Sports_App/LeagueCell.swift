//
//  LeagueCell.swift
//  Sports_App
//
//  Created by Ziyad Qassem on 28/09/2023.
//

import UIKit

class LeagueCell: UITableViewCell {

    @IBOutlet weak var LeagueView: UIView!
    @IBOutlet weak var youtubeimage: UIImageView!
    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet weak var leagueImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        LeagueView.layer.cornerRadius = LeagueView.frame.size.height / 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
