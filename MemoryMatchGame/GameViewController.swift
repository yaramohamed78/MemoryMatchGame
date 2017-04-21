//
//  GameViewController.swift
//  MemoryMatchGame
//
//  Created by yara mohamed on 4/19/17.
//  Copyright © 2017 yara mohamediCode. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    
    
       @IBOutlet var gameButtons: [UIButton]!
       var inGame : Bool = false
       var selectedButton : UIButton? = nil
       var imagesIndex = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
       var correctPairs = 0
       var images = [#imageLiteral(resourceName : "card1"),#imageLiteral(resourceName : "card2"),#imageLiteral(resourceName : "card3"),
           #imageLiteral(resourceName : "card4"),
           #imageLiteral(resourceName : "card5"),
           #imageLiteral(resourceName : "card6"),
           #imageLiteral(resourceName : "card7"),
           #imageLiteral(resourceName : "card8"),
           #imageLiteral(resourceName : "card1"),
           #imageLiteral(resourceName : "card2"),
           #imageLiteral(resourceName : "card3"),
           #imageLiteral(resourceName : "card4"),
           #imageLiteral(resourceName : "card5"),
           #imageLiteral(resourceName : "card6"),
           #imageLiteral(resourceName : "card7"),
           #imageLiteral(resourceName : "card8")]
    
    
    

    /*
    initialize background for buttons
    by creating random number from specific values in the array
    to choose the image at random , we remove the random number
    to ensure that the image is not repeated more than twice
    We will also add tag to it to be able to use the tag value 
     after that
    */
    
    func assignImages()
    {
        var i : Int = 0
        while imagesIndex.count > 0 {
            
            // random key from array
            let arrayKey = Int(arc4random_uniform(UInt32(imagesIndex.count)))
            
            // your random number
            let randNum = imagesIndex[arrayKey]
            
            // make sure the number isnt repeated
            imagesIndex.remove(at: arrayKey)
            gameButtons[i].setBackgroundImage(images[randNum], for: .normal)
            gameButtons[i].tag=randNum
            i+=1
            
        }

    }
    //Show all images for the buttons
    func showAll()
    {
        for i in 0..<gameButtons.count
        {
        UIView.transition(with: gameButtons[i],
                              duration: 1,
                              options: .transitionFlipFromLeft,
                              animations: { self.gameButtons[i].setBackgroundImage(self.images[self.gameButtons[i].tag], for: .normal)},
                              completion: nil)
        }
    }
    
    //Hide all images for buttons and show the back default image instead
    func hideAll()
    {
        for i in 0..<gameButtons.count
        {
        UIView.transition(with: gameButtons[i],
                          duration: 1,
                          options: .transitionFlipFromRight,
                          animations: { self.gameButtons[i].setBackgroundImage(#imageLiteral(resourceName: "back"), for: .normal)},
                          completion: nil)
        }
    }
    
    /*
     -Handler for button touched
     -if two images r choosed , we will call compare function to compare between them
    */
    @IBAction func imageTouched(_ sender: UIButton)
    {
        if(inGame==false)
        {
            inGame = true
            selectedButton = sender
            UIView.transition(with: selectedButton!,
                              duration: 1,
                              options: .transitionFlipFromLeft,
                              animations: { self.selectedButton?.setBackgroundImage(self.images[(self.selectedButton?.tag)!], for: .normal)},
                              completion: nil)

        }
        else
        {
            UIView.transition(with: sender,
                              duration: 1,
                              options: .transitionFlipFromLeft,
                              animations: { sender.setBackgroundImage(self.images[sender.tag], for: .normal)},
                              completion: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.compareCards(self.selectedButton!,sender)
                
            })
            
        }
        
        
    }
    
    //Compare 2 cards by comparing their tags
    func compareCards(_ btn1: UIButton , _ btn2: UIButton)
    {
        if(abs(btn1.tag-btn2.tag)==8)
        {
            //equal

            btn1.isHidden = true
            btn2.isHidden = true
            correctPairs+=1
            win()
            
            
        }
        else
        {
            //Not Equal
            UIView.transition(with: btn1,
                              duration: 1,
                              options: .transitionFlipFromRight,
                              animations: { btn1.setBackgroundImage(#imageLiteral(resourceName: "back"), for: .normal)},
                              completion: nil)
            UIView.transition(with: btn2,
                              duration: 1,
                              options: .transitionFlipFromRight,
                              animations: { btn2.setBackgroundImage(#imageLiteral(resourceName: "back"), for: .normal)},
                              completion: nil)
        }
        inGame = false
    }
    
    func win()
    {
        if (correctPairs == 8)
        {
            let alert = UIAlertController(title: "Congrats", message: "You win !!", preferredStyle: UIAlertControllerStyle.alert)
            let action = UIAlertAction(title: "Play again", style: UIAlertActionStyle.default, handler: { action in self.reset()})
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func reset()
    {
        inGame = false
        imagesIndex = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
        selectedButton = nil
        correctPairs = 0
        for i in 0..<gameButtons.count
        {
        gameButtons[i].isHidden = false
        }
        startGame()
    }
    
    func startGame()
    {
        assignImages()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.hideAll()
            
        })
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        startGame()

    }
    

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}










//        for i in 0..<gameButtons.count
//        {
//        gameButtons[i].tag=i
//        ImageInd[i]=Int(arc4random_uniform(7))
//        print (ImageInd[i])
