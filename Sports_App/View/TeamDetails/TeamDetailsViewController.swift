//
//  TeamDetailsViewController.swift
//  Sports_App
//
//  Created by Malak Samir on 27/09/2023.
//

import UIKit

class TeamDetailsViewController: UIViewController {

    var team : Team?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamLogo: UIImageView!
    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teamName.text = team?.team_name
        let TeamlogoURL = URL(string: team?.team_logo ?? "")
        teamLogo.kf.setImage(with: TeamlogoURL)
        imgView.image = UIImage(named: "stadium")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, enviroment in
            
            self.collectionView.register(UINib(nibName: "PlayerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PlayerCollectionViewCell")
            return self.playersSection()
        }
            collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    func playersSection()-> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.8))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
          let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .fractionalHeight(0.7))
          let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
          group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 30)
          
          let section = NSCollectionLayoutSection(group: group)
          section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15)
       
 //       section.orthogonalScrollingBehavior = .continuous
           return section
    }
}
    
    


extension TeamDetailsViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return team?.players?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayerCollectionViewCell" , for: indexPath) as! PlayerCollectionViewCell
        if let player  = team?.players?[indexPath.row] {
            cell.setUP(player:player )
        }
            
      
        return cell
        
    }

     
}
