//
//  ViewController.swift
//  Maxus
//
//  Created by Balram Singh on 16/05/16.
//  Copyright © 2016 Balram Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view1.layer.cornerRadius = 10
        self.view2.layer.cornerRadius = 10
        self.view3.layer.cornerRadius = 10
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func menuButtonTapped(sender: UIButton) {
    }
    @IBAction func showMaxusServices(sender: UIButton) {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ServicesVC")
        self.navigationController?.pushViewController(vc!, animated: true)
    }

    @IBAction func showFinApps(sender: UIButton) {
        let calInfoVc = self.storyboard?.instantiateViewControllerWithIdentifier("CalInfoVC")
        self.navigationController?.pushViewController(calInfoVc!, animated: true)
    }
    @IBAction func showContactUs(sender: UIButton) {
        let calInfoVc = self.storyboard?.instantiateViewControllerWithIdentifier("ContactVC")
        self.navigationController?.pushViewController(calInfoVc!, animated: true)
    }
}

