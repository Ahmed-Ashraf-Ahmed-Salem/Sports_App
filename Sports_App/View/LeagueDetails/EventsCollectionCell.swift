//
//  EventsCollectionCell.swift
//  sportsApp
//
//  Created by Malak Samir on 26/09/2023.
//

import UIKit
import Kingfisher

class EventsCollectionCell: UICollectionViewCell {

    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var team2Img: UIImageView!
    @IBOutlet weak var team1Img: UIImageView!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var team2Label: UILabel!
    @IBOutlet weak var team1Label: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       backgroundImg.layer.cornerRadius = 25
       // eventImage.layer.cornerRadius = 25
       // team1Label.textColor = .black
      //  timeLabel.textColor = .black
      //  dateLabel.textColor = .black
      //  team2Label.textColor = .black
    }

    func setup(event: Event?){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let someDate = dateFormatter.date(from: event?.event_date ?? "") ?? Date()
        let date2 = Date()
        print(someDate)
        print(date2)
        if (someDate > date2){
            team1Label.text = event?.event_home_team
            team2Label.text = event?.event_away_team
            timeLabel.text = event?.event_time
            dateLabel.text = event?.event_date
            let homeTeamLogo = URL(string: event?.home_team_logo ?? "")
            team1Img.kf.setImage(with: homeTeamLogo)
            let awayTeamLogo = URL(string: event?.away_team_logo ?? "")
            team2Img.kf.setImage(with: awayTeamLogo)
            let leagueLogo = URL(string: event?.league_logo ?? "")
            eventImage.kf.setImage(with: leagueLogo)
        }else{
            /*
            team1Label.text = ""
            team2Label.text = ""
            timeLabel.text = ""
            dateLabel.text = ""
            let homeTeamLogo = URL(string: "")
            team1Img.kf.setImage(with: homeTeamLogo)
            let awayTeamLogo = URL(string: "")
            team2Img.kf.setImage(with: awayTeamLogo)
            let leagueLogo = URL(string: "")
            eventImage.kf.setImage(with: leagueLogo)
             */
            print("No Events")
        }
    }
}
