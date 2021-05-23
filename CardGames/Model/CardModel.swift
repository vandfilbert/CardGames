//
//  CardModel.swift
//  CardGames
//
//  Created by Vanbert on 28/09/20.
//

import Foundation

class CardModel{
    
    //Array for generate cards
    var arrayOfCards = [Cards]()
    
    //------------------------------------------------------------------------------------------
    
    //Function for generate card in card cell
    func getCards(_ num:Int) -> [Cards]{
        
        //Store number has been generate
        var storeNumberArray = [Int]()
        
        //Random number for pairs of card
        while storeNumberArray.count < num{
            
            let randomNumber = arc4random_uniform(22) + 1
            
            if storeNumberArray.contains(Int(randomNumber)) == false{
             
                //Track the number
                print(randomNumber)
                
                //Append number
                storeNumberArray.append(Int(randomNumber))
                
                //Generate card one
                let cardOne = Cards()
                cardOne.imageName = "card\(randomNumber)"
                arrayOfCards.append(cardOne)
                
                //generate card two
                let cardTwo = Cards()
                cardTwo.imageName = "card\(randomNumber)"
                arrayOfCards.append(cardTwo)
                
            }
            
        }
      
        //TODO: Random array
        for i in 0...arrayOfCards.count-1{
            
            let tempNumber = Int(arc4random_uniform(UInt32(arrayOfCards.count)))
            swap(i, tempNumber)
            
        }
        
        //Return Array
        return arrayOfCards
    }
    
    //------------------------------------------------------------------------------------------
    
    func swap(_ num1:Int,_ num2:Int){
        
        let tempStore = arrayOfCards[num1]
        arrayOfCards[num1] = arrayOfCards[num2]
        arrayOfCards[num2] = tempStore
        
    }
    
}
