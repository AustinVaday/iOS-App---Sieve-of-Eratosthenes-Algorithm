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
    var numPartitionsSet: Int = 1
    
    // Display all numbers by default
    var segmentedControlType : SegmentedControlEnum = .ALL_NUM_SEGMENT
    
    
    // -- Constants --
    let reusableCellIdentifier = "numberCell"
    let minCellSpacing   = CGFloat(0)
    let numCellPerRow    =  CGFloat(10)
    let minNumCellPerRow = CGFloat(5)
    let collectionViewPadding = CGFloat(20+20)
    let partitionMax  = 5000    // Partitions display by 5000 elements at a time.

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
        
        
        // If the up-to-num given is less than the partition max, just perform the algorithm for that number
        if (receivedNum <= partitionMax)
        {
            sieveObj = SieveOfEratosthenses(newUpToNum: receivedNum)
            sieveObj.computeSieveOfEratosthenses()
            
            
            // Update numbers, primes, and composite arrays
            updateAllSieveArrays()


        }
        else // Partition the work accordingly, but perform first partition right now.
        {
            //Pre-thread operations
            sieveObj = SieveOfEratosthenses(newUpToNum: partitionMax)
            sieveObj.computeSieveOfEratosthenses()
            
            // Update numbers, primes, and composite arrays
            updateAllSieveArrays()
            
            numPartitionsSet = 1
            
            // Compute rest asynchronously on background thread, immediately after the first partition
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) { () -> Void in
                
                self.sieveObj.computeSieveOfEratosthenses(self.receivedNum)
                
                self.updateAllSieveArrays()

                 //Update arrays when this thread operation finishes
                print("End threading")
                
                // Perform UI operation on main thread
//                dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                
                    // Also invalidate collection view layouts so we can reset the cells
                    self.numberCollectionView.collectionViewLayout.invalidateLayout()
                    self.primeCollectionView.collectionViewLayout.invalidateLayout()
                    self.compositeCollectionView.collectionViewLayout.invalidateLayout()
//                })
                
                
                
                

            }
        }



        // Store the width of the collection view so that we can programatically
        // enforce 10 numbers per row
        collectionViewWidth = UIScreen.mainScreen().bounds.width - collectionViewPadding
        
        // Enforce 10 cells per row by calculating how much space there is for each cell
        calcCellSize = (collectionViewWidth - numCellPerRow * minCellSpacing) / numCellPerRow
        
        // If the circles are too small, re-calculate with only 5 cells per row
        if (calcCellSize < 30)
        {
            calcCellSize = (collectionViewWidth - numCellPerRow * minCellSpacing) / minNumCellPerRow
        }

        
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
            if (receivedNum <= partitionMax * numPartitionsSet)
            {
                
                print ("Received num: ", receivedNum, " PartitionMax * numPartitionsSet = ", partitionMax * numPartitionsSet)
                
                sizeNum = receivedNum - 1
            }
            else
            {
                sizeNum = partitionMax * numPartitionsSet
                
                print("Size Num is now", sizeNum)
            }

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
       
        // Border thickness will vary. Thicker border => prime.
        var borderThickness: CGFloat = 2.0
        
        // Reference the storyboard cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reusableCellIdentifier, forIndexPath: indexPath) as! NumberCollectionViewCell
        
        // Rasterize the cell to increase FPS when scrolling
        cell.layer.shouldRasterize = true
        cell.layer.rasterizationScale = UIScreen.mainScreen().scale
        
        if (collectionView.isEqual(numberCollectionView))
        {
            
            // Start from 1, not 0 (ignore the number 0)
            let cellIndex = indexPath.item + 1
            
            print(cellIndex)
            
            print ("partitionMax * numPartitions Set: ", partitionMax * numPartitionsSet);
            
            // If we hit the partitionmax, load more cells and incrememnt our count of partitions!
            if (cellIndex + 1 == (partitionMax * numPartitionsSet))
            {
                numPartitionsSet++
                
                // This resets number of cells we have
                numberCollectionView.reloadSections(NSIndexSet(index: 0))
            }

            // Set the visible cell number
            cell.cellLabel.text = String(cellIndex)
            
            // Set the background color:
            // True  ==> Is a prime number     ==> Green
            // False ==> Is not a prime number ==> Red
            if (sieveArray[cellIndex])
            {
                cell.backgroundColor = UIColor.greenColor()
                borderThickness = 3.0
            }
            else
            {
                cell.backgroundColor = UIColor.redColor()
            }
  
        }
        else if (collectionView.isEqual(primeCollectionView))
        {
            let cellIndex = indexPath.item

            // Store next prime number
            cell.cellLabel.text = String(primeNumsArray[cellIndex])
            
            cell.backgroundColor = UIColor.greenColor()
            borderThickness = 3.0

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
        
        // Border width varies on the number
        cell.layer.borderWidth = borderThickness
        
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
    
    func updateAllSieveArrays()
    {
        // Generate the sieveArray that holds all true/false values
        // (information whether an index/number is prime or not)
        sieveArray = sieveObj.returnListOfNums()
        
        print("Sieve array size is: ", sieveArray.count)
        
        // Store respective prime and nonprime arrays, too
        primeNumsArray     = sieveObj.returnListOfPrimeNums()
        compositeNumsArray = sieveObj.returnListOfCompositeNums()
    }

}

