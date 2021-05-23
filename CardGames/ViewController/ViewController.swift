//
//  ViewController.swift
//  CardGames
//
//  Created by Vanbert on 27/09/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var buttonPlay: UIButton!
    @IBOutlet weak var buttonPlay2: UIButton!
    var number:Int = 0
    
    //------------------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        buttonPlay.layer.cornerRadius = 20
        buttonPlay2.layer.cornerRadius = 20
        
        SoundsManage.playSound(.soundHome)
    }
    
    //------------------------------------------------------------------------------------------
    
    //Segue to Page Game
    @IBAction func buttonPlay(_ sender: UIButton) {
        
        if sender.currentTitle! == "4x4"{
            print("Button 4x4 : \(sender.currentTitle!)")
            self.number = 8
            print("Print Number : \(number)")
        }else if sender.currentTitle! == "6x6"{
            print("Button 6x6 : \(sender.currentTitle!)")
            self.number = 18
            print("Print Number : \(number)")
        }
        self.animateButton(sender)
        performSegue(withIdentifier: "toPageGameCard", sender: self)
        
    }
    
    //------------------------------------------------------------------------------------------
    
    //Function to passing value
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if segue.destination is CardGameViewController
        {
            let vc = segue.destination as? CardGameViewController
            vc?.manyCards = number
        }
        
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

