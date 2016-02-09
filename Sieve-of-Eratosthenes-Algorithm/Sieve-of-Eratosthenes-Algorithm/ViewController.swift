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
            let alert = UIAlertController(title: "Please try again...", message: "You must enter in a number.", preferredStyle: UIAlertControllerStyle.Alert)
            
            // Create the action to add to alert
            let alertAction = UIAlertAction(title: "Try again", style: UIAlertActionStyle.Default, handler: nil)
            
            // Add the action to the alert
            alert.addAction(alertAction)
            
            showViewController(alert, sender: self)

        }
        // If too many digits
        else if (numberTextFieldString.characters.count > maxNumInput)
        {
            // Create alert to send to user
            let alert = UIAlertController(title: "Please try again...", message: "Sorry, the number of digits you specified is too big.", preferredStyle: UIAlertControllerStyle.Alert)
            
            // Create the action to add to alert
            let alertAction = UIAlertAction(title: "Try again", style: UIAlertActionStyle.Default, handler: nil)
            
            // Add the action to the alert
            alert.addAction(alertAction)
            
            showViewController(alert, sender: self)
        }
        else
        {
            performSegueWithIdentifier("toAlgorithmSegue", sender: nil)
        }
    }
    
}

