//
//  CalculatorInfoViewController.swift
//  Maxus
//
//  Created by Balram Singh on 16/05/16.
//  Copyright © 2016 Balram Singh. All rights reserved.
//

import UIKit

class CalculatorInfoViewController: UIViewController {

    @IBOutlet weak var button1: UIView!
    @IBOutlet weak var button2: UIView!
    @IBOutlet weak var button3: UIView!
    
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var innerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.button1.layer.cornerRadius = 10.0
        self.button2.layer.cornerRadius = 10.0
        self.button3.layer.cornerRadius = 10.0
        
        self.navigationController?.navigationBarHidden = true
        
        // Do any additional setup after loading the view.
        
        self.overlayView.hidden = true
        self.innerView.layer.cornerRadius = 10.0
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
   
    @IBOutlet weak var showInfo: NSLayoutConstraint!
    @IBAction func backPressed(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
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
