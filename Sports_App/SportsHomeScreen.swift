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
    
    @IBAction func toggleHomeScreen(_ sender: Any) {
        isToggle.toggle()
        
        if isToggle {
            let itemWidth = (collectionView.frame.size.width - 40) / 2
            flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
            flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 10, right: 12)
            toggleBtn.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        } else {
            flowLayout.itemSize = CGSize(width: 368, height: 135)
            toggleBtn.setImage(UIImage(systemName: "rectangle.grid.2x2"), for: .normal)
        }
        
        collectionView.reloadData()
    }
    
}
