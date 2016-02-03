//
//  SieveOfEratosthenes.swift
//  Sieve-of-Eratosthenes-Algorithm
//
//  Created by Austin Vaday on 2/3/16.
//  Copyright © 2016 None. All rights reserved.
//


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
    init(upToNum: Int)
    {
        // If number is 0 or negative, log an error to console
        if (upToNum <= 0)
        {
            print("SieveOfEratosthenes initialized with invalid upToNum of ", upToNum)
            print("Continuing with default upToNum: ", UP_TO_NUM_DEFAULT)
            
            // Set back to default state of UP_TO_NUM_DEFAULT
            self.upToNum = UP_TO_NUM_DEFAULT
        }
        else
        {
            self.upToNum = upToNum
        }
        
        // Generate a new list for private class variable, listOfNums
        generateNewListOfNums(upToNum)
        
        //outputListOfNums()
        
    }
    
    // Method to change upToNum. Will also change array (only if necessary)
    func setUpToNum(newUpToNum: Int)
    {
        // If the new upToNum is less than or equal to the old upToNum, 
        // do not allocate more space, just update the upToNum
        if (newUpToNum <= upToNum)
        {
            upToNum = newUpToNum
        }
        // We need to allocate more space 
        // note: This does not wipe current array, so true/false values will remain the same unless the array is re-generated
        else
        {
            // Calculate the number of new indices we have to add to the array
            let numNewIndices = newUpToNum - upToNum
            
            for (var index = 0; index < numNewIndices; index++)
            {
                listOfNums.append(true)
            }
        }
        
        outputListOfNums()
        
    }
    
    // Implementation of the algorithm using the initialized array
    func computeSieveOfEratosthenses()
    {
            //TODO: Implement algorithm
    }
    

    private
    
    /*********************************************
    * Helper Methods
    **********************************************/
    func generateNewListOfNums(upToNum: Int)
    {
        // Initialize array of upToNum boolean values
        listOfNums = Array<Bool>(count: upToNum, repeatedValue: true)
        
        // Set 0 and 1 to be not prime, because our algorithm does not involve these indices
        listOfNums[0] = false
        listOfNums[1] = false
    }

    func outputListOfNums()
    {
        for var i = 0; i < listOfNums.count; i++
        {
            print("Index: ", i, "; Value ", listOfNums[i])
        }
    }

    /*********************************************
    * Constants
    **********************************************/
    let UP_TO_NUM_DEFAULT = 500

    /*********************************************
     * Variables
     **********************************************/
    var upToNum: Int!
    var listOfNums: Array<Bool>!
    
}


