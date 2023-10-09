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
    var l : League!
    
    var  chosen_sport : String = ""
    var  leagueTeams : [Team] = []
    var upcomingEvents: [Event]?
    var latestEvents: [Event]?
    
    // My View Model Var
    var teamDetail: TeamsViewModel? = TeamsViewModel()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var favBtn: UIBarButtonItem!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewWillAppear(_ animated: Bool) {
      
        
    loadFromCoreData()
        for favorite in favoriteArray{
            if(favorite.league_key == leagueID){
                fav = true
                favBtn.tintColor = .red
                favBtn.image = UIImage(systemName: "heart.fill")
            }
        }
        print(chosen_sport)
        print(leagueID)
        self.getLatestEvents()
        self.getLeaguesEvents()
 //       self.getLeagueTeams()
        self.collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFromCoreData()
        
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
        self.getLatestEvents()
        self.getLeaguesEvents()
 //       self.getLeagueTeams()
        teamDetail?.getLeagueTeams(LeagueId: leagueID, chosen_sport: chosen_sport)
        
        teamDetail?.bindingData = {
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
    /*
    func getLeagueTeams (){
        NetworkManager.getTeams(LeagueId: leagueID, chosen_sport: chosen_sport) { teamslist, error in
            if let allTeams = teamslist {
                self.leagueTeams = allTeams
                self.collectionView.reloadData()
            }
        }
    }
     */
    func getLeaguesEvents(){
        NetworkManager.getEvents(leagueId: leagueID, chosen_sport: chosen_sport) { events, error in
            if let events = events{
           //     print(events)
           //     self.upcomingEvents?.append(contentsOf: events)
                self.upcomingEvents = events
                self.collectionView.reloadData()
            }
        }
    }
    func getLatestEvents(){
        NetworkManager.getLatestEvents(leagueId: leagueID, chosen_sport: chosen_sport) { events, error in
            if let events = events{
           //     print(events)
           //     self.upcomingEvents?.append(contentsOf: events)
                self.latestEvents = events
                self.collectionView.reloadData()
            }
        }
    }
    func loadFromCoreData(){
        let request :NSFetchRequest<FavoriteLeagues> = FavoriteLeagues.fetchRequest()
        do {
            favoriteArray = try context.fetch(request)
        }
        catch{
            print(error.localizedDescription)
        }
        
    }
     
    var favoriteArray = [FavoriteLeagues]()
    @IBAction func favoriteBtn(_ sender: Any) {
        fav.toggle()
        loadFromCoreData()

        if fav == true {
            favBtn.tintColor = .red
            favBtn.image = UIImage(systemName: "heart.fill")
         
            let favEntity = NSEntityDescription.entity(forEntityName: "FavoriteLeagues", in: context)!
            let favLeague = NSManagedObject(entity: favEntity, insertInto: context) as! FavoriteLeagues
            
            favLeague.league_name = l.league_name
            favLeague.league_key = Int32(l.league_key!)
            favLeague.sport_type = chosen_sport
            
            let imageUrl = URL(string: l.league_logo!)

            let imageData = try! Data(contentsOf: imageUrl!)

            let image = UIImage(data: imageData)
            let img = image!.pngData();

            favLeague.league_logo = img; //<--Image data is stored in the core data entity.
    
            
            print(favLeague.league_name)
            favoriteArray.append(favLeague)
            
            do{
                try context.save()
            }
            catch{
                print(error.localizedDescription)
            }

        }
        else{
            favBtn.tintColor = .black
            favBtn.image = UIImage(systemName: "heart")
            
            for i in 0...favoriteArray.count-1{
                print(favoriteArray.count-1)
                print(i)
                if(favoriteArray[i].league_key == Int32(l.league_key!)){
                    context.delete(favoriteArray[i])

                  favoriteArray.remove(at:i)
                 
                    do{
                        try context.save()
                        break
                    }
                    catch{
                        print(error.localizedDescription)
                        break
                    }
                }
            }
        }
        loadFromCoreData()
    }
        
    
    func teamsSection()-> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
        , heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
          let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(180)
          , heightDimension: .absolute(200))
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
        , heightDimension: .absolute(220))
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
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize
        , subitems: [item])
            group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
            , bottom: 15, trailing: 15)
            
        let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15
            , bottom: 10, trailing: 0)
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
            return upcomingEvents?.count ?? 0
        }
        else if (section == 1){
            return   latestEvents?.count ?? 0
        }
        else {
            return teamDetail?.getTeams()?.count ?? 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    //    var cell : UICollectionViewCell?
        if(indexPath.section==0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventsCollectionCell" , for: indexPath) as! EventsCollectionCell
            cell.setup(event: upcomingEvents?[indexPath.row])
            return cell
        }
        else if (indexPath.section==1){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestEventsCollectionViewCell" , for: indexPath) as! LatestEventsCollectionViewCell
            cell.setup(event: latestEvents?[indexPath.row])
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCollectionViewCell" , for: indexPath) as! TeamCollectionViewCell
            cell.setupCell(team: (teamDetail?.getTeam(indexPath: indexPath))!)
            return cell
        }
        
        
  //      return cell!
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (indexPath.section == 2) {
            let vc = storyboard?.instantiateViewController(identifier: "TeamsVC") as! TeamDetailsViewController
            vc.team = teamDetail?.getTeam(indexPath: indexPath)
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
              
                
                
                sectionHeader.HeaderTitle?.text = "Upcoming Events"
                
                return sectionHeader
            case 1 :
              
                
                sectionHeader.HeaderTitle?.text = "Latest Events"
                
                return sectionHeader
                
            case 2 :
              //  let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! SectionHeader
                
                
                sectionHeader.HeaderTitle?.text = "Teams "
                
                return sectionHeader
                
            default :
               // let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! SectionHeader
                
                
                sectionHeader.HeaderTitle?.text = "Sports"
                
                return sectionHeader
            }
            
        }
        return UICollectionViewCell()
    }
    
}
