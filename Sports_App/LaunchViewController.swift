//
//  LaunchViewController.swift
//  Sports_App
//
//  Created by Ziyad Qassem on 29/09/2023.
//

import UIKit
import Lottie

class LaunchViewController: UIViewController {
    
    
    
    @IBOutlet weak var onboardingLottieView: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      onboardingLottieView.contentMode = .scaleAspectFit
        onboardingLottieView.loopMode = .loop
        onboardingLottieView.play()
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(showFirstView), userInfo: nil, repeats: false)
        // Do any additional setup after loading the view.
    }
    
    @objc func showFirstView(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SportsHomeScreen") as! SportsHomeScreen
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
      
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
