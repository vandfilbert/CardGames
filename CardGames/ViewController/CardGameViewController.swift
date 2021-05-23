//
//  CardGameViewController.swift
//  CardGames
//
//  Created by Vanbert on 27/09/20.
//  

import UIKit

class CardGameViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var myMoveScore: UILabel!
    
    var model = CardModel()
    var cardsArray = [Cards]()
    var manyCards:Int = 0
    var firstFlippedCard:IndexPath?
    var timer:Timer?
    var myTime:Float = 60 * 1000
    var myMove:Int = 0
    
    //------------------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self

        // Do any additional setup after loading the view.
        // Call getCards
        cardsArray = model.getCards(manyCards)
        print("Number Transfer: \(manyCards)")
        
        //Timer object
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerCountDown), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
        
    }
    
    //------------------------------------------------------------------------------------------
    
    override func viewDidAppear(_ animated: Bool) {
        
        SoundsManage.playSound(.shuffle)
        
    }
    
    //------------------------------------------------------------------------------------------
    
    //For timer
    @objc func timerCountDown(){
        
        myTime -= 1
        //Convert to seconds
        let countdown = String(format: "%.2f", myTime/1000)
        timerLabel.text = "Time Remain: \(countdown)s"
        
        if myTime == 0{
            
            //Stop the timer
            timer?.invalidate()
            timerLabel.textColor = UIColor.red
            
            //Check end Game
            checkEndGame()
        
        }
        
    }
    
    //------------------------------------------------------------------------------------------
    
    //UICollectionView protocol methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //To get 16 or 36 cards
        print("Cards total = \(cardsArray.count)")
        return cardsArray.count
    
    }
    
    //------------------------------------------------------------------------------------------
    
    //Reuse the card
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //Create object collection view cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        //Get the card is trying to display
        let card = cardsArray[indexPath.row]
        
        //Set the card to display
        cell.setCard(card)
        
        return cell
        
    }
    
    //------------------------------------------------------------------------------------------
    
    //For check user tapped
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if myTime == 0{
            return
        }
        
        //Cell user selected
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        //Card user selected
        let card = cardsArray[indexPath.row]
        
        if card.isFlipped == false && card.isMatched == false{
            
            card.isFlipped = true
            cell.flip()
            SoundsManage.playSound(.flip)
            
            if firstFlippedCard == nil{
                
                //Assign the first card
                firstFlippedCard = indexPath
            
            }else{
                
                //Call matching logic
                checkMatches(indexPath)
                
            }
            
        }
        
    }
    
    //------------------------------------------------------------------------------------------
    
    //Game logic in here
    func checkMatches(_ secondFlippedCard:IndexPath){
        
        //Score Flipped Card
        myMove += 1
        myMoveScore.text = String("Your Move : \(myMove)")
        
        //Get cell two card
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCard!) as? CardCollectionViewCell
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCard) as? CardCollectionViewCell
        //Get card two card
        let cardOne = cardsArray[firstFlippedCard!.row]
        let cardTwo = cardsArray[secondFlippedCard.row]
        
        if cardOne.imageName == cardTwo.imageName {
            
            SoundsManage.playSound(.match)
            
            //Set status match card
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            //Remove card
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
            //Check card unmatch
            checkEndGame()
            
        }else{
            
            //Set status no match card
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            //Flipback
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
            
            SoundsManage.playSound(.nomatch)
            
        }
        
        //Reload the first card if nil
        if cardOneCell == nil{
            collectionView.reloadItems(at: [firstFlippedCard!])
        }
        
        //Reset the match
        firstFlippedCard = nil
        
    }
    
    //------------------------------------------------------------------------------------------
    
    //Logic to stop the game
    func checkEndGame(){
        
        //Initialize the winning
        var winning = true
        var title = ""
        var message = ""
        
        for card in cardsArray{
            
            if card.isMatched == false{
                winning = false
                break
            }
            
        }
        
        if winning{
            
            if myTime > 0{
                timer?.invalidate()
            }
            
            title = "Cool!"
            message = "You finish the challenge..."
            
        }else{
            
            if myTime > 0{
                return
            }
            
            title = "Poor You !"
            message = "Please try again letter"
            
        }
        
        //Call the alert
        showAlertCondition(title, message)
        
    }
    
    //------------------------------------------------------------------------------------------
    
    //Function for alert action
    func showAlertCondition(_ title:String, _ message:String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { (_) in
            self.performSegue(withIdentifier: "toPageHighScoreGame", sender: self)
        }
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
        
    }
    
    //------------------------------------------------------------------------------------------
    
    //Function to passing value
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if segue.destination is HighScoreViewController{
            
            let vc = segue.destination as? HighScoreViewController
            vc?.highScoreArray.append(myTime/1000)
            
        }
        
    }
    
    //------------------------------------------------------------------------------------------
    
}
