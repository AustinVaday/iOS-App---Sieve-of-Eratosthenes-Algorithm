//
//  SieveOfEratosthenes.swift
//  Sieve-of-Eratosthenes-Algorithm
//
//  Created by Austin Vaday on 2/3/16.
//  Copyright © 2016 None. All rights reserved.
//

import UIKit

/*********************************************
* SieveOfEratosthenses Class:
*   Implements an algorithm to find all the
*   prime numbers up to a specific value.
*
*   IN : upToVal -> integer
*   OUT: Outputs to console (for now)
**********************************************/
class SieveOfEratosthenses
{
    /*********************************************
     * Methods
     **********************************************/
     
    // Init method to set upToNum upon creation
    init(newUpToNum: Int)
    {
        // If number is 0 or negative, log an error to console
        if (newUpToNum <= 0)
        {
            print("SieveOfEratosthenes initialized with invalid upToNum of ", newUpToNum)
            print("Continuing with default upToNum: ", UP_TO_NUM_DEFAULT)
            
            // Set back to default state of UP_TO_NUM_DEFAULT
            upToNum = UP_TO_NUM_DEFAULT
        }
        else
        {
            upToNum = newUpToNum
        }
        
        // Generate a new list for private class variable, listOfNums
        generateNewListOfNums(upToNum)
        
        listOfPrimeNums = Array<Int>()
        listOfCompositeNums = Array<Int>()
        
        //outputListOfNums()
        
    }
    
    // Method to change upToNum. Will also change array (only if necessary)
    func setUpToNum(newUpToNum: Int)
    {

        // If number is 0 or negative, log an error to console
        if (newUpToNum <= 0)
        {
            print("SieveOfEratosthenes initialized with invalid upToNum of ", upToNum)
            print("Continuing with default upToNum: ", UP_TO_NUM_DEFAULT)
            
            // Set back to default state of UP_TO_NUM_DEFAULT
            upToNum = UP_TO_NUM_DEFAULT
        }
        // If the new upToNum is less than the old upToNum,
        // truncate from the list
        else if (newUpToNum < upToNum)
        {
            // Calculate the number of indices we must truncate
            let numTruncIndices = upToNum - newUpToNum
            
            for (var index = 0; index < numTruncIndices; index++)
            {
                listOfNums.removeLast()
            }
            
            upToNum = newUpToNum
        }
        // We need to allocate more space
        // note: This does not wipe current array, so true/false values will remain the same unless the array is re-generated
        else if (newUpToNum > upToNum)
        {
            // Calculate the number of new indices we have to add to the array
            let numNewIndices = newUpToNum - upToNum
            
            for (var index = 0; index < numNewIndices; index++)
            {
                listOfNums.append(true)
            }
            
            upToNum = newUpToNum
        }
        
        
    }
    
    // Implementation of the algorithm using the initialized array
    func computeSieveOfEratosthenses()
    {

        let size    : Int = listOfNums.count
        let sqrtSize: Int = Int(sqrt(Float(size)))
        
        // Iterate through array of boolean values. Stop *after* the square root of
        // the size of the array because we can't eliminate any other numbers in the
        // range. 
        // I.e. If size = 30, then sqrtSize = 5. 6 * 6 is out range for our inner loop.
        for (var i = 2; i <= sqrtSize; i++)
        {
            
            // If the indexed boolean value is true, it is prime. So we take this prime number
            // and set all of its multiples to false
            if (listOfNums[i])
            {

                // Start at the first multiple of number i (i^2), set it to false. 
                // Then proceed to set all other multiples of this prime number to false.
                // Ex: If i is 2, we set index 4 to false, index 6 to false, index 8 to false, and so on.
                for (var j = i*i; j < size; j = j + i)
                {
                    listOfNums[j] = false
                }
            }
            
        }
        
//        // Fill up other arrays on the fly, ignore the number 0
//        for (var i = 1; i < size; i++)
//        {
//            // If true, it is prime
//            if (listOfNums[i])
//            {
//                listOfPrimeNums.append(i)
//            }
//            else
//            {
//                listOfCompositeNums.append(i)
//            }
//        }
        
        
    }
    
    // Wrapper class for the algorithm
    func computeSieveOfEratosthenses(newUpToNum: Int)
    {
        setUpToNum(newUpToNum)
        computeSieveOfEratosthenses()
    }
    
    // Return a boolean array
    func returnListOfNums() -> Array<Bool>
    {
        return listOfNums
    }
    
    func returnListOfPrimeNums() -> Array<Int>
    {
        let size    : Int = listOfNums.count

        // Fill up other arrays on the fly, ignore the number 0
        for (var i = 1; i < size; i++)
        {
            // If true, it is prime
            if (listOfNums[i])
            {
                listOfPrimeNums.append(i)
            }
        }
        
        return listOfPrimeNums
    }
    
    func returnListOfCompositeNums() -> Array<Int>
    {
        let size    : Int = listOfNums.count

        // Fill up other arrays on the fly, ignore the number 0
        for (var i = 1; i < size; i++)
        {
            // If false, it is composite
            if (!listOfNums[i])
            {
                listOfCompositeNums.append(i)
            }
        }
        return listOfCompositeNums
    }
    
    
    /*********************************************
    * Helper Methods
    **********************************************/
    private func generateNewListOfNums(upToNum: Int)
    {
        // Initialize array of upToNum boolean values
        listOfNums = Array<Bool>(count: upToNum, repeatedValue: true)
        
        // Set 0 and 1 to be not prime, because our algorithm does not involve these indices
        if (upToNum > 0)
        {
            listOfNums[0] = false
        }
        
        if (upToNum > 1)
        {
            listOfNums[1] = false
        }
    }

    func outputListOfNums()
    {
        for var i = 0; i < listOfNums.count; i++
        {
            print("Index: ", i, "; Value ", listOfNums[i])
        }
    }
    
    func outputListOfPrimeNums()
    {
        for var i = 0; i < listOfNums.count; i++
        {
            if (listOfNums[i])
            {
                print(i)
            }
        }
    }
    
    /*********************************************
    * Constants
    **********************************************/
    let UP_TO_NUM_DEFAULT = 500

    /*********************************************
     * Variables
     **********************************************/
    private var upToNum: Int!
    private var listOfNums: Array<Bool>!        // TRUE: Not prime; FALSE: Prime
    private var listOfPrimeNums: Array<Int>!    // A listing of all prime numbers
    private var listOfCompositeNums:Array<Int>! // A listing of all non-prime numbers
    
}


