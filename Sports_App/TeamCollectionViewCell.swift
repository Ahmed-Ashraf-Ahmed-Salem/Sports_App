//
//  TeamCollectionViewCell.swift
//  Sports_App
//
//  Created by Malak Samir on 27/09/2023.
//

import UIKit

class TeamCollectionViewCell: UICollectionViewCell {
    
    

    @IBOutlet weak var greyView: UIView!
    @IBOutlet weak var teamLogo: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

        greyView.layer.cornerRadius = 25
    }
    func setupCell(team : Team){
        teamName.text = team.team_name
        let teamImageURL = URL(string: team.team_logo ?? "")
        teamLogo.kf.setImage(with: teamImageURL)
    }
}
