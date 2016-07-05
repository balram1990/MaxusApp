//
//  CalculatorInfoViewController.swift
//  Maxus
//
//  Created by Balram Singh on 16/05/16.
//  Copyright © 2016 Balram Singh. All rights reserved.
//

import UIKit

class CalculatorInfoViewController: PopoverViewController {

    @IBOutlet weak var middleScrollView: UIScrollView!
    @IBOutlet weak var benefitsButton: UIButton!
    @IBOutlet weak var button1: UIView!
    @IBOutlet weak var button2: UIView!
    @IBOutlet weak var button3: UIView!
    
    @IBOutlet weak var lastView: UIView!
    @IBOutlet weak var benefitsContainerView: UIView!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var overlayContainerHeightConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.benefitsButton.layer.cornerRadius = 10.0
        self.button1.layer.cornerRadius = 10.0
        self.button2.layer.cornerRadius = 10.0
        self.button3.layer.cornerRadius = 10.0
        self.benefitsContainerView.layer.cornerRadius = 10.0
        self.navigationController?.navigationBarHidden = true
        
        // Do any additional setup after loading the view.
        
        self.overlayView.hidden = true
        self.innerView.layer.cornerRadius = 10.0
        
        if isPhone4CategoryDevice() {
            overlayContainerHeightConstraint.constant = (self.view.frame.size.height * 0.30)
        }
    }
    
    func isPhone4CategoryDevice () -> Bool {
        let height = UIScreen.mainScreen().bounds.size.height
        return (height == 480 || height == 568)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var close: UIButton!
    @IBAction func closeOverlay(sender: UIButton) {
        self.overlayView.hidden = true
    }
    
    @IBAction func showInfo(sender: AnyObject) {
        self.overlayView.hidden = false
    }
    @IBAction func calculateBenfits(sender: UIButton) {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("CalculatorVC")
        self.navigationController?.pushViewController(vc!, animated: true)
    }

    @IBAction func menuButtonClicked(sender: UIButton) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    @IBAction func showMenu(sender: AnyObject) {
        self.showPopover(self.menuButton)
        
    }
   
    @IBOutlet weak var showInfo: NSLayoutConstraint!
    @IBAction func backPressed(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        self.middleScrollView.contentSize = CGSizeMake(CGRectGetMaxX(self.middleScrollView.frame), CGRectGetMaxY(self.lastView.frame))
    }
    /*
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
