//
//  KeyboardViewController.swift
//  Secure Home Gateway
//
//  Created by Chitranshu Asthana on 22/12/15.
//  Copyright © 2015 Intel Security. All rights reserved.
//

import UIKit

class KeyboardViewController : UIViewController, UITextFieldDelegate {
    var textField: UIView? = nil
    private var originalFrame: CGRect? = nil
    
    override func viewDidAppear(animated: Bool) {
        self.originalFrame = self.view.frame
    }
    
    
    func keyboardShown(notification: NSNotification) {
        let info  = notification.userInfo!
        let value: AnyObject = info[UIKeyboardFrameEndUserInfoKey]!
        
        let rawFrame = value.CGRectValue
        let keyboardFrame = view.convertRect(rawFrame, fromView: nil)
        
        let movementDuration = 0.1;
        
        if let _ = self.textField {
            let frame = (self.textField?.frame)!
            let viewFrame = self.view.frame
            if (frame.origin.y + frame.size.height) > (viewFrame.size.height - keyboardFrame.size.height) {
                let movement = -(frame.origin.y + frame.size.height - keyboardFrame.origin.y + 50);
                
                UIView.beginAnimations("anim", context: nil)
                UIView.setAnimationBeginsFromCurrentState(true)
                UIView.setAnimationDuration(movementDuration)
                self.view.frame = CGRectOffset(self.view.frame, 0, movement);
                UIView.commitAnimations();
            }
        }
    }
    
    func keyboardHidden(notification: NSNotification) {
        let movementDuration = 0.1;
        if let _ = self.originalFrame {
            let movement = (self.originalFrame?.origin.y)! - self.view.frame.origin.y;
            UIView.beginAnimations("anim", context: nil)
            UIView.setAnimationBeginsFromCurrentState(true)
            UIView.setAnimationDuration(movementDuration)
            self.view.frame = CGRectOffset(self.view.frame, 0, movement);
            UIView.commitAnimations();
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
}
