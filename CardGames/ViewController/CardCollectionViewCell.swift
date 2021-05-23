//
//  CardCollectionViewCell.swift
//  CardGames
//
//  Created by Vanbert on 28/09/20.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var frontImageView: UIImageView!
    var card:Cards?
    
    //------------------------------------------------------------------------------------------
    
    //Set the card when flip
    func setCard(_ card:Cards){
        
        //Tracking a card
        self.card = card
        
        if card.isMatched == true{
            
            backImageView.alpha = 0
            frontImageView.alpha = 0
            return
            
        }else{
            
            backImageView.alpha = 1
            frontImageView.alpha = 1
            
        }
        
        //To show the front image
        frontImageView.image = UIImage(named: card.imageName)
        
        //Determine card is flipped up or flipped down
        if card.isFlipped {
            
            //Make sure front image on top
            UIView.transition(from: backImageView, to: frontImageView, duration: 0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
            
        }else{
            
            //Make sure back image on top
            UIView.transition(from: frontImageView, to: backImageView, duration: 0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
            
        }
        
    }
    
    //------------------------------------------------------------------------------------------
    
    //To flip the card when card close
    func flip(){
        
        UIView.transition(from: backImageView, to: frontImageView, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        
    }
    
    //------------------------------------------------------------------------------------------
    
    //To flip the card when open
    func flipBack(){
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            
            UIView.transition(from: self.frontImageView, to: self.backImageView, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        
        }
        
    }
    
    //------------------------------------------------------------------------------------------
    
    //Remove card from display
    func remove(){
        
        //Change the opacity so it's look like disapear
        backImageView.alpha = 0
        //Make delay to remove
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            self.frontImageView.alpha = 0
        }, completion: nil)
        
    }
    
    //------------------------------------------------------------------------------------------
    
}
