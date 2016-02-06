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
        
        // Store reference for the destination View Controller
        let destinationVC = segue.destinationViewController as! AlgorithmViewController
        
        destinationVC.receivedString = numberTextField.text
        
    }


}

