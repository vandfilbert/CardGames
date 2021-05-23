//
//  HighScoreViewController.swift
//  CardGames
//
//  Created by Vanbert on 27/09/20.
//

import UIKit

class HighScoreViewController: UIViewController {

    @IBOutlet weak var buttonRetry: UIButton!
    @IBOutlet weak var score1: UILabel!
    @IBOutlet weak var score2: UILabel!
    
    var highScoreArray = [Float]()
    
    
    //------------------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        buttonRetry.layer.cornerRadius = 20
        print("Log Array Count : \(highScoreArray.count)")
        SoundsManage.playSound(.soundScore)
        
    }
    
    //------------------------------------------------------------------------------------------
    
    override func viewDidAppear(_ animated: Bool) {
        
        highScoreArray.sort(by: >)
        if highScoreArray.count != 0 {
            
            for i in 0...highScoreArray.count-1{
                
                if i < 5{
                    
                    print("Log Score \(i): \(highScoreArray[i])")
                    score1.text?.append("\(i+1)) \(highScoreArray[i])s\n")
                    
                }else{
                    
                    print("Log Score \(i): \(highScoreArray[i])")
                    score2.text?.append("\(i+1)) \(highScoreArray[i])s\n")
                    
                }
                
            }
            
        }
        
    }
    
    //------------------------------------------------------------------------------------------
    
    @IBAction func buttonRetry(_ sender: UIButton) {
        
        self.animateButton(sender)
        performSegue(withIdentifier: "toPageStartGame", sender: self)
        
    }
    
    //------------------------------------------------------------------------------------------
    
    //Function for animation button
    func animateButton(_ viewToAnimate: UIView){
        
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 20, options: .curveEaseIn, animations: {
            
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
            
        }) { (_) in
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 2, options: .curveEaseIn, animations: {
                
                viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
            
            }, completion: nil)
        }
        
    }
    
    //------------------------------------------------------------------------------------------

}
