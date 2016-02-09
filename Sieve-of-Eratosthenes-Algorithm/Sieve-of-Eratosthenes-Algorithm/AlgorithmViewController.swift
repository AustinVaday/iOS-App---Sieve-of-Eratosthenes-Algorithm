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
    
    // 3 different collection views to switch between
    @IBOutlet weak var numberCollectionView: UICollectionView!
    @IBOutlet weak var primeCollectionView: UICollectionView!
    @IBOutlet weak var compositeCollectionView: UICollectionView!
    @IBOutlet weak var numberSegmentedControl: UISegmentedControl!
    
    // This string will store data being passed from ViewController
    var receivedString: String!
    // Stores object passed in from ViewController
    var sieveObj: SieveOfEratosthenses!
    var receivedNum: Int!
    var sieveArray: Array<Bool>!
    var primeNumsArray: Array<Int>!
    var compositeNumsArray: Array<Int>!
    var collectionViewWidth: CGFloat!
    var calcCellSize: CGFloat!
    
    // Display all numbers by default
    var segmentedControlType : SegmentedControlEnum = .ALL_NUM_SEGMENT
    
    
    // -- Constants --
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
        
        /*
            // Create object with the receivedNum
            sieveObj = SieveOfEratosthenses(newUpToNum: receivedNum)
            
            // Perform long-running operation on background thread
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
                self.sieveObj.computeSieveOfEratosthenses()
            }
        */
        
        sieveObj = SieveOfEratosthenses(newUpToNum: receivedNum)
        sieveObj.computeSieveOfEratosthenses()
        
        // Generate the sieveArray that holds all true/false values
        // (information whether an index/number is prime or not)
        sieveArray = sieveObj.returnListOfNums()
        
        // Store respective prime and nonprime arrays, too
        primeNumsArray     = sieveObj.returnListOfPrimeNums()
        compositeNumsArray = sieveObj.returnListOfCompositeNums()
        
        // Store the width of the collection view so that we can programatically 
        // enforce 10 numbers per row
        collectionViewWidth = UIScreen.mainScreen().bounds.width - collectionViewPadding
        
        // Enforce 10 cells per row by calculating how much space there is for each cell
        calcCellSize = (collectionViewWidth - numCellPerRow * minCellSpacing) / numCellPerRow
        
        // Since default segment is "All Numbers", make sure other collectionViews are hidden
        primeCollectionView.hidden      = true
        compositeCollectionView.hidden  = true
        
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
        return CGSize(width: calcCellSize, height: calcCellSize)
        
    }
    
    // Denote how many cells we need to make for each view
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var sizeNum:Int!
        
        if (collectionView.isEqual(numberCollectionView))
        {
            // We need a collection of n-1 cells (the aglorithm does not include last digit of the specified up-to-num)
            // We also want to start from index 1 (so, take out a cell)
            sizeNum = receivedNum - 1
        }
        else if (collectionView.isEqual(primeCollectionView))
        {
            sizeNum = primeNumsArray.count
        }
        else if (collectionView.isEqual(compositeCollectionView))
        {
            sizeNum = compositeNumsArray.count
        }

        return sizeNum;
    }
    
    // Tell the collection view about the cell we want to use at a particular index of the collection
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
       
        
        // Reference the storyboard cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reusableCellIdentifier, forIndexPath: indexPath) as! NumberCollectionViewCell
        
        
        if (collectionView.isEqual(numberCollectionView))
        {
            // Start from 1, not 0 (ignore the number 0)
            let cellIndex = indexPath.item + 1
            
            // Set the visible cell number
            cell.cellLabel.text = String(cellIndex)
            
            // Set the background color:
            // True  ==> Is a prime number     ==> Green
            // False ==> Is not a prime number ==> Red
            if (sieveArray[cellIndex])
            {
                cell.backgroundColor = UIColor.greenColor()
                
                //TODO: Color-blind flag
                //            cell.cellLabel.textColor = UIColor.blackColor()
                
            }
            else
            {
                cell.backgroundColor = UIColor.redColor()
                
                //TODO: Color-blind flag
                //            // Set the cell's text label to white color so that numbers are visible
                //            cell.cellLabel.textColor = UIColor.whiteColor()
                
                //            // Make cells square
                //            cell.layer.cornerRadius = 0
            }
        }
        else if (collectionView.isEqual(primeCollectionView))
        {
            let cellIndex = indexPath.item

            // Store next prime number
            cell.cellLabel.text = String(primeNumsArray[cellIndex])
            
            cell.backgroundColor = UIColor.greenColor()

        }
        else if (collectionView.isEqual(compositeCollectionView))
        {
            let cellIndex = indexPath.item
            
            // Store next composite number
            cell.cellLabel.text = String(compositeNumsArray[cellIndex])
            
            cell.backgroundColor = UIColor.redColor()

        }
        
        // -- Modify cell attributes further --
        
        // Make cells circular
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

        // Show respective collection view (we have 3 of them)
        switch segmentedControlType
        {
            case .PRIME_NUM_SEGMENT:
                
                numberCollectionView.hidden     = true
                compositeCollectionView.hidden  = true
                primeCollectionView.hidden      = false
                
                break
            case .ALL_NUM_SEGMENT:

                numberCollectionView.hidden     = false
                compositeCollectionView.hidden  = true
                primeCollectionView.hidden      = true
                
                break
            case .COMPOSITE_NUM_SEGMENT:
                
                numberCollectionView.hidden     = true
                compositeCollectionView.hidden  = false
                primeCollectionView.hidden      = true
                
                break
        }

        
        
//        // Invalidate layout so we can update/remove/add cells as requested
//        numberCollectionView.collectionViewLayout.invalidateLayout()
        
    }
    

}
    
