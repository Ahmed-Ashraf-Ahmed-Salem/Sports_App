//
//  TheLeaguesDetailsViewController.swift
//  sportsApp
//
//  Created by Malak Samir on 26/09/2023.
//

import UIKit
import CoreData

class TheLeaguesDetailsViewController: UIViewController {
    var fav : Bool = false
    var  leagueID : Int = 0
    var l : League?
    var name : String = ""
    var  chosen_sport : String = ""
    
    // My View Model Var
    var leagueDetails: LeagueDetailsViewModel? = LeagueDetailsViewModel()
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var favBtn: UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool) {
        if (leagueDetails?.coreDataManager?.checkFav(id: leagueID) == true){
            favBtn.tintColor = .red
            favBtn.image = UIImage(systemName: "heart.fill")
        }
        else {
            favBtn.tintColor = .black
            favBtn.image = UIImage(systemName: "heart")
        }
        self.collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = name
        collectionView.dataSource = self
        collectionView.delegate = self

        if (leagueDetails?.coreDataManager?.checkFav(id: leagueID ) == true){
            favBtn.tintColor = .red
            favBtn.image = UIImage(systemName: "heart.fill")
        }

        leagueDetails?.getLeagueTeams(LeagueId: leagueID, chosen_sport: chosen_sport)
        
        leagueDetails?.bindingData = {team, error in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        leagueDetails?.getLeaguesEvents(leagueID: leagueID, chosen_sport: chosen_sport)
        leagueDetails?.getLatestEvents(leagueID: leagueID, chosen_sport: chosen_sport)
        leagueDetails?.bindingResult = {result, error in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }

        let layout = UICollectionViewCompositionalLayout { sectionIndex, enviroment in
                    switch sectionIndex {
                    case 0 :
                        self.collectionView.register(UINib(nibName: "EventsCollectionCell", bundle: nil), forCellWithReuseIdentifier: "EventsCollectionCell")
                        return self.upcomingEventsSection()
                    
                    case 1 :
                        self.collectionView.register(UINib(nibName: "LatestEventsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LatestEventsCollectionViewCell")
                        return self.latestEventsSection()
                    default:
                        self.collectionView.register(UINib(nibName: "TeamCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TeamCollectionViewCell")
                        return self.teamsSection()                   }
                }
        collectionView.setCollectionViewLayout(layout, animated: true)
        
    }

    @IBAction func favoriteBtn(_ sender: Any) {
        
        if (leagueDetails?.coreDataManager?.checkFav(id: (l?.league_key)!)==false){
            favBtn.tintColor = .red
            favBtn.image = UIImage(systemName: "heart.fill")
         
            leagueDetails?.coreDataManager?.addingToCoreData(l:l! , chosen_sport:chosen_sport)

        }
        else{
            favBtn.tintColor = .black
            favBtn.image = UIImage(systemName: "heart")
            leagueDetails?.coreDataManager?.deleteFromCoreData(key: l?.league_key! ?? 205)

        }
       
    }
        
    
    func teamsSection()-> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
        , heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
          let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(200)
          , heightDimension: .absolute(250))
          let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize
          , subitems: [item])
          group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
          , bottom: 8, trailing: 30)
          
          let section = NSCollectionLayoutSection(group: group)
          section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15
          , bottom: 10, trailing: 15)
       
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [self.supplementtryHeader()]
           return section
    }
    
    func upcomingEventsSection()-> NSCollectionLayoutSection {
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
      , heightDimension: .fractionalHeight(1))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
       
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
        , heightDimension: .absolute(180))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize
        , subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
        , bottom: 8, trailing: 15)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15
        , bottom: 10, trailing: 15)
     
          section.orthogonalScrollingBehavior = .paging
        section.boundarySupplementaryItems = [self.supplementtryHeader()]
         return section
    }
  
    
    func latestEventsSection()->NSCollectionLayoutSection {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
            , heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
        , heightDimension: .absolute(225))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 15)
            
        let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 0)
        section.boundarySupplementaryItems = [self.supplementtryHeader()]
        
            return section
        }
    

}
extension TheLeaguesDetailsViewController :UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(section == 0){
            return leagueDetails?.getEvents()?.count ?? 0
        }
        else if (section == 1){
            return   leagueDetails?.getEvents()?.count ?? 0
        }
        else {
            return leagueDetails?.getTeams()?.count ?? 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    //    var cell : UICollectionViewCell?
        if(indexPath.section==0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventsCollectionCell" , for: indexPath) as! EventsCollectionCell
            cell.setup(event: leagueDetails?.getEvent(indexPath: indexPath))
            return cell
        }
        else if (indexPath.section==1){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestEventsCollectionViewCell" , for: indexPath) as! LatestEventsCollectionViewCell
            cell.setup(event: leagueDetails?.getEvent(indexPath: indexPath))
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCollectionViewCell" , for: indexPath) as! TeamCollectionViewCell
            cell.setupCell(team: (leagueDetails?.getTeam(indexPath: indexPath))!)
            return cell
        }
        
        
  //      return cell!
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (indexPath.section == 2) {
            let vc = storyboard?.instantiateViewController(identifier: "TeamsVC") as! TeamDetailsViewController
            vc.team = leagueDetails?.getTeam(indexPath: indexPath)
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    //Header Functions
    func supplementtryHeader()->NSCollectionLayoutBoundarySupplementaryItem{
        
        .init(layoutSize: .init(widthDimension:.fractionalWidth(1), heightDimension: .estimated(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top )
        
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader{
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! SectionHeader
            switch indexPath.section {
            case 0 :
              
                
                
                sectionHeader.HeaderTitle?.text = "Incoming Events"
                return sectionHeader
            case 1 :
                sectionHeader.HeaderTitle?.text = "Latest Events"
                return sectionHeader
            case 2 :
                sectionHeader.HeaderTitle?.text = "Teams "
                return sectionHeader
            default :
                sectionHeader.HeaderTitle?.text = "Sports"
                
                return sectionHeader
            }
        }
        return UICollectionViewCell()
    }
    
}
