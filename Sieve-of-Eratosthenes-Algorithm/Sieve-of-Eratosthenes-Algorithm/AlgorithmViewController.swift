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
    var sieveArray: Array<Bool>!
    
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
        
        // Generate the sieveArray that holds all true/false values
        // (information whether an index/number is prime or not)
        sieveArray = sieveObj.returnListOfNums()

    }
    
    override func viewDidAppear(animated: Bool) {


    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // Collection view functionality
    
    // Tell the collection view how many cells we need to make
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // We need a collection of n cells (the aglorithm does not include last digit of the specified up-to-num)
        return receivedNum;
    }
    
    // Tell the collection view about the cell we want to use at a particular index of the collection
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cellIndex = indexPath.item
        
        // Reference the storyboard cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reusableCellIdentifier, forIndexPath: indexPath) as! NumberCollectionViewCell
        
        // Set the visible cell number
        cell.cellLabel.text = String(cellIndex)
        
        print(cellIndex)
        // Set the background color: 
        // True  ==> Is a prime number     ==> Green
        // False ==> Is not a prime number ==> Red
        if (sieveArray[cellIndex])
        {
            cell.backgroundColor = UIColor.greenColor()
        }
        else
        {
            cell.backgroundColor = UIColor.redColor()
        }
        
        // -- Modify cell attributes further --
        
        // Set border color to black
        cell.layer.borderColor = UIColor.blackColor().CGColor
        
        // Increase border thickness
        cell.layer.borderWidth = 2.0
        
        // Make cells circular
        cell.layer.cornerRadius = cell.frame.size.width / 2
        
        
        
        return cell
    }
    
        
        
        
        
}
    
