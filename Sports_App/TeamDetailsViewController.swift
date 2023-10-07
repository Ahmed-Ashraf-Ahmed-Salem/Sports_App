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
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var twitterBtn: UIButton!
    @IBOutlet weak var officialWebsiteBtn: UIButton!
    @IBOutlet weak var tshirtImg: UIImageView!
    @IBOutlet weak var greyView: UIView!
    @IBOutlet weak var teamCity: UILabel!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamLogo: UIImageView!
    
    
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
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, enviroment in
            
            self.collectionView.register(UINib(nibName: "PlayerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PlayerCollectionViewCell")
            return self.playersSection()
        }
            collectionView.setCollectionViewLayout(layout, animated: true)
        
    }
    func playersSection()-> NSCollectionLayoutSection{
            
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
                                                  , heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
              let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(200)
                                                     , heightDimension: .fractionalHeight(1))
              let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize
              , subitems: [item])
              group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
              , bottom: 0, trailing: 30)
              
              let section = NSCollectionLayoutSection(group: group)
              section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15
              , bottom: 0, trailing: 15)
           
            section.orthogonalScrollingBehavior = .continuous
            section.boundarySupplementaryItems = [self.supplementtryHeader()]
               return section
        }
            
        }
    
    


extension TeamDetailsViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayerCollectionViewCell" , for: indexPath) as! PlayerCollectionViewCell
       
        return cell
        
    }
    
    func supplementtryHeader()->NSCollectionLayoutBoundarySupplementaryItem{
        
        .init(layoutSize: .init(widthDimension:.fractionalWidth(1), heightDimension: .estimated(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top )
        
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader{
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "h", for: indexPath) as! Header
            
                
                sectionHeader.HeaderTitle?.text = "Players"
                
                return sectionHeader
           
            
        }
        return UICollectionViewCell()
    }
     
}
