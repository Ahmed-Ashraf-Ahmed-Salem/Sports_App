//
//  SportsHomeScreen.swift
//  Sports_App
//
//  Created by Ahmed Ashraf on 27/09/2023.
//

import UIKit

class SportsHomeScreen: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var toggleBtn: UIButton!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let sports: [Sports] = [
        Sports(title: "Football", image: "football"),
        Sports(title: "Basketball", image: "basketball"),
        Sports(title: "Cricket", image: "cricket"),
        Sports(title: "Tennis", image: "tennis"),
    ]
    var isToggle: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
        collectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "mainCell1")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateCollectionViewLayout()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sports.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCell1", for: indexPath) as! CustomCollectionViewCell
        let sport = sports[indexPath.row]
        cell.imgView.image = UIImage(named: sport.image ?? "sports")
        cell.collectionViewItemLabel.text = sport.title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let stoaryBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = stoaryBoard.instantiateViewController(withIdentifier: "LeagueVC") as! LeagueVC
        let sport = sports[indexPath.row]

        vc.chosen_Sports = sport.title?.lowercased() ?? "football"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func toggleHomeScreen(_ sender: Any) {
        isToggle.toggle()
        updateCollectionViewLayout()
    }
    
    func updateCollectionViewLayout(){
        if isToggle {
            let itemWidth = (collectionView.frame.size.width - 40) / 2
            flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
            toggleBtn.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        } else {
            flowLayout.itemSize = CGSize(width: collectionView.frame.size.width - 24, height: 135)
            toggleBtn.setImage(UIImage(systemName: "rectangle.grid.2x2"), for: .normal)
        }
        
        collectionView.reloadData()
    }
    
}
