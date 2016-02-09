//
//  HelperFunctions.swift
//  Sieve-of-Eratosthenes-Algorithm
//
//  Created by Austin Vaday on 2/8/16.
//  Copyright © 2016 None. All rights reserved.
//

import UIKit

func showAlert(title: String, message: String, buttonTitle: String, sender: AnyObject)
{

    // Create alert to send to user
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
    
    // Create the action to add to alert
    let alertAction = UIAlertAction(title: buttonTitle, style: UIAlertActionStyle.Default, handler: nil)
    
    // Add the action to the alert
    alert.addAction(alertAction)
    
    sender.showViewController(alert, sender: sender)
}