//
//  TeamDetailsViewController.swift
//  Sports_App
//
//  Created by Malak Samir on 27/09/2023.
//

import UIKit

class TeamDetailsViewController: UIViewController {

    @IBOutlet weak var officialWebsiteBtn: UIButton!
    @IBOutlet weak var tshirtImg: UIImageView!
    @IBOutlet weak var greyView: UIView!
    @IBOutlet weak var teamCity: UILabel!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamLogo: UIImageView!
    @IBOutlet weak var playgroundImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
     
        greyView.layer.cornerRadius = 15
        officialWebsiteBtn.layer.cornerRadius = 10
       
    }
    

    

}
