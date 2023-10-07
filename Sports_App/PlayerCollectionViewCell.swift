//
//  PlayerCollectionViewCell.swift
//  Sports_App
//
//  Created by Malak Samir on 07/10/2023.
//

import UIKit

class PlayerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var whiteView: UIView!
    
    @IBOutlet weak var greyView: UIView!
    
    
    @IBOutlet weak var playerImg: UIImageView!
    
    @IBOutlet weak var playerName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        greyView.layer.cornerRadius = 25
    }

}
