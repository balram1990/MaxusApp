//
//  ServicsViewController.swift
//  Maxus
//
//  Created by Balram Singh on 18/05/16.
//  Copyright © 2016 Balram Singh. All rights reserved.
//

import UIKit

class ServicsViewController: PopoverViewController {

    @IBOutlet weak var financeButton: UIButton!
    @IBOutlet weak var consultButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.financeButton.layer.cornerRadius = 10.0
        self.consultButton.layer.cornerRadius = 10.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(sender: AnyObject) {
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
    @IBAction func menuButtonClicked(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func showFinanceApps(sender: AnyObject) {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("CalInfoVC")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func consultation(sender: AnyObject) {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ContactVC")
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    @IBOutlet weak var menuButton: UIButton!
    @IBAction func showMenu(sender: AnyObject) {
        self.showPopover(self.menuButton)
    }
    
}
