//
//  GameViewController.swift
//  MemoryMatch
//
//  Created by yara mohamed on 4/18/17.
//  Copyright © 2017 yara mohamediCode. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    
    @IBOutlet var imageButtons: [UIButton]!
 
    var ImageInd: [Int]=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    


    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0..<imageButtons.count{
            imageButtons[i].tag=i
            ImageInd[i]=Int(arc4random_uniform(7))
            print (ImageInd[i])
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func createCards()
    {
        for index in 0..<imageButtons.count/2
        {
            
        }
    }

}
