//
//  AlgorithmViewController.swift
//  Sieve-of-Eratosthenes-Algorithm
//
//  Created by Austin Vaday on 2/5/16.
//  Copyright © 2016 None. All rights reserved.
//

import UIKit


class AlgorithmViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var numberCollectionView: UICollectionView!
    @IBOutlet weak var numberSegmentedControl: UISegmentedControl!
    
    // This string will store data being passed from ViewController
    var receivedString: String!
    var receivedNum: Int!
    var sieveObj: SieveOfEratosthenses!
    var sieveArray: Array<Bool>!
    var collectionViewWidth: CGFloat!
    var calcCellSize: CGFloat!
    
    let reusableCellIdentifier = "numberCell"
    let minCellSpacing = CGFloat(3)
    let numCellPerRow  = CGFloat(10)
    let collectionViewPadding = CGFloat(20+20)
    
    // Constants for segmented control, raw type of Int
    enum SegmentedControlEnum : Int
    {
        case PRIME_NUM_SEGMENT
        case ALL_NUM_SEGMENT
        case COMPOSITE_NUM_SEGMENT
    }
//    let PRIME_NUM_SEGMENT       = 0
//    let ALL_NUM_SEGMENT         = 1
//    let COMPOSITE_NUM_SEGMENT   = 2
    
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
        
        // Store the width of the collection view so that we can programatically 
        // enforce 10 numbers per row
        collectionViewWidth = UIScreen.mainScreen().bounds.width - collectionViewPadding
        
        // Enforce 10 cells per row by calculating how much space there is for each cell
        calcCellSize = (collectionViewWidth - numCellPerRow * minCellSpacing) / numCellPerRow

    }
    
    override func viewDidAppear(animated: Bool) {


    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // Collection view functionality
    
    // Tell the collection view about the size of our cells
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        // Set the size of the cell so that we can have 10 cells per row
        return CGSize(width: calcCellSize, height: calcCellSize)
    }
    
    
    
    // Tell the collection view how many cells we need to make
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // We need a collection of n-1 cells (the aglorithm does not include last digit of the specified up-to-num)
        // We also want to start from index 1 (so, take out a cell)
        return receivedNum - 1;
    }
    
    // Tell the collection view about the cell we want to use at a particular index of the collection
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // Start from 1, not 0
        let cellIndex = indexPath.item + 1
        
        // Reference the storyboard cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reusableCellIdentifier, forIndexPath: indexPath) as! NumberCollectionViewCell
        
        // Set the visible cell number
        cell.cellLabel.text = String(cellIndex)
        
        print(cellIndex)
        
//        // Set the size of the cell so that we can have 10 cells per row
//        cell.frame.size.width  = calcCellSize
//        cell.frame.size.height = calcCellSize
        
        // Set the background color: 
        // True  ==> Is a prime number     ==> Green
        // False ==> Is not a prime number ==> Red
        if (sieveArray[cellIndex])
        {
            cell.backgroundColor = UIColor.greenColor()
            
            // Make cells circular
            cell.layer.cornerRadius = cell.frame.size.width / 2
        }
        else
        {
            cell.backgroundColor = UIColor.redColor()
            
            // Make cells square
            cell.layer.cornerRadius = 0
        }
        
        // -- Modify cell attributes further --
        
        // Set border color to black
        cell.layer.borderColor = UIColor.blackColor().CGColor
        
        // Increase border thickness
        cell.layer.borderWidth = 2.0
        

        
        
        
        return cell
    }
    
    // Segmented control functionality
    @IBAction func onSegmentedControlValueChanged(sender: AnyObject) {
        
        // Store current segmented selection location
        let segmentedSelection = SegmentedControlEnum(rawValue: numberSegmentedControl.selectedSegmentIndex)!

        switch segmentedSelection
        {
        case .PRIME_NUM_SEGMENT:
            
            print ("DISPLAY PRIME ONLY")
            
            break
        case .ALL_NUM_SEGMENT:
            
            print ("DISPLAY ALL NUMS")
            
            break
        case .COMPOSITE_NUM_SEGMENT:
            
            print ("DISPLAY COMPOSITE ONLY")
            
            break

        }
        
        
        
        
    }
    
    
        
        
        
        
}
    
