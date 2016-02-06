//
//  AlgorithmViewController.swift
//  Sieve-of-Eratosthenes-Algorithm
//
//  Created by Austin Vaday on 2/5/16.
//  Copyright © 2016 None. All rights reserved.
//

import UIKit

class AlgorithmViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var numberLabel: UILabel!

    
    // This string will store data being passed from ViewController
    var receivedString: String!
    var receivedNum: Int!
    var sieveObj: SieveOfEratosthenses!
    
    let reusableCellIdentifier = "numberCell"

    
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
    
    
    // Collection view functionality
    
    // Tell the collection view how many cells we need to make
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // We need a collection of n - 1 cells (the aglorithm does not include last digit of the specified up-to-num)
        return receivedNum - 1;
    }
    
    // Tell the collection view about the cell we want to use at a particular index of the collection
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // Reference the storyboard cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reusableCellIdentifier, forIndexPath: indexPath) as! NumberCollectionViewCell
        
        // Set the cell number
        cell.cellLabel.text = "1"
        
        // Set the background color: 
        // Green ==> Is a prime number
        // Red   ==> Is not a prime number
        cell.backgroundColor = UIColor.blueColor()
        
        return cell
    }
    
        
        
        
        
}
    
