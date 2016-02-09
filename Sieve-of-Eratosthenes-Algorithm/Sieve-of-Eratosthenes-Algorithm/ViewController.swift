//
//  ViewController.swift
//  Sieve-of-Eratosthenes-Algorithm
//
//  Created by Austin Vaday on 2/2/16.
//  Copyright © 2016 None. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var inputString: String!
    let nonDigitChars = NSCharacterSet.decimalDigitCharacterSet().invertedSet
    let maxNumInput = 9

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Threading limitations...
            let numBackgroundComputations = 5 // Number of background computations we can perform without a noticable delay
            var sieveObj:SieveOfEratosthenses!

            // Perform long-running operation for algorithm on background thread
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
                
                print("Begin thread dispatch")
                self.sieveObj = SieveOfEratosthenses(newUpToNum: self.numBackgroundComputations)
                
                // This method will compute the algorithm on the background thread, as an abstraction to the user.
                self.sieveObj.computeSieveOfEratosthenses()
                
                print("Completed filling array")
            }
        */
        
        spinner.hidden = true
        spinner.stopAnimating()
        
        // Ensure only numbers can be entered in to text field
        numberTextField.keyboardType = UIKeyboardType.NumberPad
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Only perform following data operations when transitioning to AlgorithmViewController
        if (segue.identifier == "toAlgorithmSegue")
        {
            // Store reference for the destination View Controller
            let destinationVC = segue.destinationViewController as! AlgorithmViewController
            
            destinationVC.receivedString = numberTextField.text
            
            /*
                // This will return the sieveObj at any point of time (no matter whether the dispatched operation
                // has not finished)
                destinationVC.sieveObj = self.sieveObj
            */
            
            // Begin playing spinner until segue occurs
            spinner.hidden = false
            spinner.startAnimating()
        
        }
        

    }
    
    // Ensure that if user types in a letter, delete it immediately
    @IBAction func onNumberTextFieldEditingChanged(sender: AnyObject) {
       
        inputString = numberTextField.text
        
        if (!inputString.isEmpty)
        {
            // Get range of all characters in the string that are not digits
            let nonDigitRange = inputString.rangeOfCharacterFromSet(nonDigitChars)
            
            // If range of characters in given string has any non-digit characters
            // Then we must remove them
            if (nonDigitRange != nil)
            {
                // Remove all non-digits
                inputString.removeRange(nonDigitRange!)
                
                // Enforce this on user, set text field to no digits
                numberTextField.text = inputString
            }
        }

    }
    
    @IBAction func onGoButtonPressed(sender: UIButton) {
        
        let numberTextFieldString = numberTextField.text!
        
        // If empty input
        if (numberTextFieldString.isEmpty)
        {
            // Create alert to send to user
            showAlert( "Please try again...", message: "You must enter in a number.", buttonTitle: "Try again", sender: self)
        }
//        // If too many digits
//        else if (numberTextFieldString.characters.count > maxNumInput)
//        {
//            // Create alert to send to user
//             showAlert( "Please try again...", message: "Sorry, the number of digits you specified is too big.", buttonTitle: "Try again", sender: self)
//        }
        else
        {
            performSegueWithIdentifier("toAlgorithmSegue", sender: nil)
        }
    }
    
}

