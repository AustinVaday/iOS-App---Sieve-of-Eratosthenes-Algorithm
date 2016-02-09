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
    
    var inputString: String!
    let nonDigitChars = NSCharacterSet.decimalDigitCharacterSet().invertedSet
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ensure only numbers can be entered in to text field
        numberTextField.keyboardType = UIKeyboardType.NumberPad
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Only perform following data operations when transitioning to AlgorithmViewController
        if (segue.destinationViewController.isKindOfClass(AlgorithmViewController))
        {
            // Store reference for the destination View Controller
            let destinationVC = segue.destinationViewController as! AlgorithmViewController
            
            destinationVC.receivedString = numberTextField.text
        
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
    
    
}

