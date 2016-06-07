//
//  ContactViewController.swift
//  Maxus
//
//  Created by Balram Singh on 19/05/16.
//  Copyright © 2016 Balram Singh. All rights reserved.
//

import UIKit
import MessageUI

class ContactViewController: KeyboardViewController, UITextViewDelegate, MFMailComposeViewControllerDelegate, OptionsDelegate {

    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextFiedl: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var middleContainerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(self.keyboardShown), name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(self.keyboardHidden), name: UIKeyboardDidHideNotification, object: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: #selector(ContactViewController.done))
        let toolBar = UIToolbar(frame: CGRectMake(0, 0, self.view.frame.size.width, 44))
        toolBar.items = [doneButton]
        self.phoneTextField.inputAccessoryView = toolBar
        
        let doneButtonTV = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: #selector(ContactViewController.done))
        let toolBarTV = UIToolbar(frame: CGRectMake(0, 0, self.view.frame.size.width, 44))
        toolBarTV.items = [doneButtonTV]
        self.commentTextView.inputAccessoryView = toolBarTV
        
        self.submitButton.layer.cornerRadius = 10.0
        
        self.middleContainerView.layer.cornerRadius = 10.0
        
        self.commentTextView.layer.cornerRadius = 5.0
        self.commentTextView.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.commentTextView.layer.borderWidth = 1.0
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        self.textField = textField
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        self.textField = textView
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == nameTextField {
            self.emailTextFiedl.becomeFirstResponder()
        } else if textField == emailTextFiedl {
            self.phoneTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func done () {
        if  phoneTextField.isFirstResponder() {
            self.commentTextView.becomeFirstResponder()
        } else {
            self.commentTextView.resignFirstResponder()
        }
    }
    @IBAction func back(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    @IBAction func submit(sender: AnyObject) {
        let nameCharCount = self.nameTextField.text?.characters.count
        let phoneChanCount = self.phoneTextField.text?.characters.count
        let validEmail = containsEmail()
        
        if nameCharCount == 0 || phoneChanCount == 0 {
            let alertController = UIAlertController(title: "Invalid inputs", message: "Textfields can not be empty. Please enter valid data", preferredStyle: .Alert)
            let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alertController.addAction(action)
            self.presentViewController(alertController, animated: true, completion: nil)
        }else if validEmail == false {
            let alertController = UIAlertController(title: "Invalid inputs", message: "Email is not valid", preferredStyle: .Alert)
            let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alertController.addAction(action)
            self.presentViewController(alertController, animated: true, completion: nil)
        } else {
            //show email
            let mailComposeViewController = configuredMailComposeViewController()
            if MFMailComposeViewController.canSendMail() {
                self.presentViewController(mailComposeViewController, animated: true, completion: nil)
            } else {
                self.showSendMailErrorAlert()
            }
        }
        
    }
    
    func containsEmail () -> Bool {
        if let text = self.emailTextFiedl.text {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluateWithObject(text)
        } else {
            return false
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        mailComposerVC.setSubject("Contact Me")
        mailComposerVC.setCcRecipients(["info@maxusplans.com"])
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let alertController = UIAlertController(title: "Can not send mail", message: "Mail is not configured on your device. Please configure it first and retry.", preferredStyle: .Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alertController.addAction(action)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: MFMailComposeViewControllerDelegate
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
            controller.dismissViewControllerAnimated(true) {
                if result == MFMailComposeResultSent {
                    //show Thanks Screen
                    let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ThanksVC")
                    self.navigationController?.pushViewController(vc!, animated: true)
            }
        }
        
    }
    @IBAction func showOverlay(sender: AnyObject)
    {
        self.overlayView.hidden = false
    }
    

    @IBAction func closeOverlayView(sender: AnyObject) {
        self.overlayView.hidden = true
    }
    
    @IBAction func menuButtonclicked(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    @IBOutlet weak var menuButton: UIButton!
    @IBAction func showMenu(sender: AnyObject) {
        
        var popController = OptionsTableViewController(style: .Plain)
        popController = OptionsTableViewController(style: .Plain)
        popController.delegate = self
        popController.popoverPresentationController!.sourceView = self.menuButton; //The view containing the anchor rectangle for the popover.
        popController.popoverPresentationController!.sourceRect = CGRectMake(10, menuButton.frame.size.height  + 2, 0, 0); //The rectangle in the specified view in which to anchor the popover.
        popController.popoverPresentationController?.permittedArrowDirections = .Up
        self.presentViewController(popController, animated: true, completion: nil)
    }
    
    func didSelectOption(index: Int) {
        self.dismissViewControllerAnimated(true, completion: nil)
        switch index {
        case 0:
            self.navigationController?.popToRootViewControllerAnimated(true)
            break
        case 1:
            if self.dynamicType  !=  ServicsViewController.self {
                let servicesVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ServicesVC")
                self.navigationController?.pushViewController(servicesVC, animated: true)
            }
        case 2:
            if self.dynamicType != CalculatorInfoViewController.self {
                let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CalInfoVC")
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        case 3:
            if self.dynamicType != ContactViewController.self {
                let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ContactVC")
                self.navigationController?.pushViewController(viewController, animated: true)
            }
            
        default:
            break
        }
        
    }
}
