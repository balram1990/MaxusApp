//
//  ResultViewController.swift
//  Maxus
//
//  Created by Balram Singh on 16/05/16.
//  Copyright © 2016 Balram Singh. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    var result : String?
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var recalculateButton: UIButton!
    @IBOutlet weak var getConsultationButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.recalculateButton.layer.cornerRadius = 10
        self.getConsultationButton.layer.cornerRadius = 10
        self.resultLabel.text = String(format: "$%@",(result?.stringByReplacingOccurrencesOfString(" ", withString: ""))!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backPressed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }

    @IBAction func getConsultation(sender: AnyObject) {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ContactVC")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func menuButtonPressed(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    @IBAction func recalculate(sender: AnyObject) {
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
