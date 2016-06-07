//
//  PopoverViewController.swift
//  Maxus
//
//  Created by Balram Singh on 07/06/16.
//  Copyright © 2016 Balram Singh. All rights reserved.
//

import UIKit

class PopoverViewController: UIViewController, OptionsDelegate {

    var popController = OptionsTableViewController(style: .Plain)
    
    func showPopover (fromView : UIView) {
        
        popController = OptionsTableViewController(style: .Plain)
        popController.delegate = self
        popController.popoverPresentationController!.sourceView = fromView; //The view containing the anchor rectangle for the popover.
        popController.popoverPresentationController!.sourceRect = CGRectMake(10, fromView.frame.size.height  + 2, 0, 0); //The rectangle in the specified view in which to anchor the popover.
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
