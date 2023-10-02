//
//  TeamDetailsViewController.swift
//  Sports_App
//
//  Created by Malak Samir on 27/09/2023.
//

import UIKit

class TeamDetailsViewController: UIViewController {

    var teamNameSTR : String = ""
    var TeamLogoURLSTR : String = ""
    @IBOutlet weak var youtubeBtn: UIButton!
    

    @IBOutlet weak var twitterBtn: UIButton!
    @IBOutlet weak var officialWebsiteBtn: UIButton!
    @IBOutlet weak var tshirtImg: UIImageView!
    @IBOutlet weak var greyView: UIView!
    @IBOutlet weak var teamCity: UILabel!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamLogo: UIImageView!
    @IBOutlet weak var playgroundImg: UIImageView!
    
    @IBOutlet weak var igBtn: UIButton!
    
    
    @IBOutlet weak var fbBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teamName.text = teamNameSTR
        let TeamlogoURL = URL(string: TeamLogoURLSTR)
        teamLogo.kf.setImage(with: TeamlogoURL)
        greyView.layer.cornerRadius = 15
        officialWebsiteBtn.layer.cornerRadius = 10
        fbBtn.layer.cornerRadius = 0.5 * fbBtn.bounds.size.width
           fbBtn.clipsToBounds = true
        
        youtubeBtn.layer.cornerRadius = 0.5 * youtubeBtn.bounds.size.width
           youtubeBtn.clipsToBounds = true
        
        twitterBtn.layer.cornerRadius = 0.5 * twitterBtn.bounds.size.width
           twitterBtn.clipsToBounds = true
        
        igBtn.layer.cornerRadius = 0.5 * igBtn.bounds.size.width
           igBtn.clipsToBounds = true
    }
    

    

}
