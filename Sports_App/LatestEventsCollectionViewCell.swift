//
//  LatestEventsCollectionViewCell.swift
//  Sports_App
//
//  Created by Malak Samir on 27/09/2023.
//

import UIKit
import Kingfisher

class LatestEventsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var team1img: UIImageView!
    
    @IBOutlet weak var team1Label: UILabel!
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
    
    let view = TheLeaguesDetailsViewController()
    
    func setup(event: Event?){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let someDate = dateFormatter.date(from: event?.event_date ?? "") ?? Date()
        let date2 = Date()
        print(someDate)
        print(date2)
        if (someDate <= date2){
            dateLabel.text = event?.event_date
            timeLabel.text = event?.event_time
            team1Label.text = event?.event_home_team
            team2Label.text = event?.event_away_team
            let homeTeamLogo = URL(string: event?.home_team_logo ?? "")
            team1img.kf.setImage(with: homeTeamLogo)
            let awayTeamLogo = URL(string: event?.away_team_logo ?? "")
            team2Img.kf.setImage(with: awayTeamLogo)
            let leagueLogo = URL(string: event?.league_logo ?? "")
            img.kf.setImage(with: leagueLogo)
            scoreLabel.text = event?.event_final_result
       }
        else{
            /*
            dateLabel.text = ""
            timeLabel.text = ""
            team1Label.text = ""
            team2Label.text = ""
            let homeTeamLogo = URL(string: "")
            team1img.kf.setImage(with: homeTeamLogo)
            let awayTeamLogo = URL(string: "")
            team2Img.kf.setImage(with: awayTeamLogo)
            let leagueLogo = URL(string: "")
            img.kf.setImage(with: leagueLogo)
            scoreLabel.text = ""
             */
            print("No Events")
        }
    }
}
