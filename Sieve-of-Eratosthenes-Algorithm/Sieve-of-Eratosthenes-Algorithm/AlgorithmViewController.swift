//
//  AlgorithmViewController.swift
//  Sieve-of-Eratosthenes-Algorithm
//
//  Created by Austin Vaday on 2/5/16.
//  Copyright © 2016 None. All rights reserved.
//

import UIKit

class AlgorithmViewController: UIViewController {

    @IBOutlet weak var numberLabel: UILabel!

    
    // This string will store data being passed from ViewController
    var receivedString: String!
    var receivedNum: Int!
    var sieveObj: SieveOfEratosthenses!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the UI text field as the string received from the previous View Controller
        numberLabel.text = receivedString
        
        // Convert string to number
        receivedNum = Int(receivedString)
        
        // Create object with the receivedNum
        sieveObj = SieveOfEratosthenses(newUpToNum: receivedNum)
        
        sieveObj.computeSieveOfEratosthenses()
        
    
    }
    
    override func viewDidAppear(animated: Bool) {
        sieveObj.outputListOfNums()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
