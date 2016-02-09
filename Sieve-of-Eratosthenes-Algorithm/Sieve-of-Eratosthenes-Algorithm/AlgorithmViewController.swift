//
//  AlgorithmViewController.swift
//  Sieve-of-Eratosthenes-Algorithm
//
//  Created by Austin Vaday on 2/5/16.
//  Copyright © 2016 None. All rights reserved.
//

import UIKit


// Constants for segmented control, raw type of Int
enum SegmentedControlEnum : Int
{
    case PRIME_NUM_SEGMENT
    case ALL_NUM_SEGMENT
    case COMPOSITE_NUM_SEGMENT
}

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
    
    // Display all numbers by default
    var segmentedControlType : SegmentedControlEnum = .ALL_NUM_SEGMENT
    
    
    let reusableCellIdentifier = "numberCell"
    let minCellSpacing = CGFloat(0)
    let numCellPerRow  = CGFloat(10)
    let collectionViewPadding = CGFloat(20+20)

    
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
        
        // Set the default size of the cell so that we can have 10 cells per row
        var cellSize : CGSize = CGSize(width: calcCellSize, height: calcCellSize)
        
        // Start from 1, not 0
        let cellIndex = indexPath.item + 1
        
        // Set size of cells based on which type of numbers to display
        switch segmentedControlType
        {
            case .PRIME_NUM_SEGMENT:
                
                print ("DISPLAY PRIME ONLY")
                
                // If the cell is not prime number, set its size to 0
                // as to "hide" it
                if (!sieveArray[cellIndex])
                {
                    cellSize.width = 0
                }
                
                break
            case .ALL_NUM_SEGMENT:
                
                print ("DISPLAY ALL NUMS")
                
                break
            case .COMPOSITE_NUM_SEGMENT:
                
                print ("DISPLAY COMPOSITE ONLY")
                
                // If the cell is a prime number, set its size to 0
                // as to "hide" it
                if (sieveArray[cellIndex])
                {
                    cellSize.width = 0
                }
                
                break
        }
        
        return cellSize
    }
    
//        // Tell the collection view how much space we want between our cells. This varies depending on which segmented mode we're in
//        func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
//    
//    
//    
//            if (segmentedControlType == .PRIME_NUM_SEGMENT || segmentedControlType == .COMPOSITE_NUM_SEGMENT)
//            {
//                return 0
//            }
//            else
//            {
//                return minCellSpacing
//            }
//        }
    
    
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
            
//            // Make cells square
//            cell.layer.cornerRadius = 0
        }
        
        // -- Modify cell attributes further --
        
        // Make cells circular
        if (cell.frame.size.height == 0.0)
        {
            print("Warning: Attempting to create a circle cell from a cell with no height.")
        }
        
        cell.layer.cornerRadius = cell.frame.size.height / 2
        
        // Set border color to black
        cell.layer.borderColor = UIColor.blackColor().CGColor
        
        // Increase border thickness
        cell.layer.borderWidth = 2.0
        
        
        return cell
    }
    
    // Segmented control functionality
    @IBAction func onSegmentedControlValueChanged(sender: AnyObject) {
    
        // Store current segmented selection location
        segmentedControlType = SegmentedControlEnum(rawValue: numberSegmentedControl.selectedSegmentIndex)!

        // Invalidate layout so we can update/remove/add cells as requested
        numberCollectionView.collectionViewLayout.invalidateLayout()
        
    }
    
    
        
        
        
        
}
    
