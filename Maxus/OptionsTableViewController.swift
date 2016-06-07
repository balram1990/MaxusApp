//
//  OptionsTableViewController.swift
//  Maxus
//
//  Created by Balram Singh on 07/06/16.
//  Copyright © 2016 Balram Singh. All rights reserved.
//

import UIKit

protocol OptionsDelegate {
    func didSelectOption (index : Int)
}

class OptionsTableViewController: UITableViewController, UIPopoverPresentationControllerDelegate {

    var options = ["Home", "Sevices", "Financial Apps", "Contact Us"]
    let CellIdentifier = "OptionCell"
    var delegate : OptionsDelegate?
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
        self.modalPresentationStyle = .Popover;
        self.popoverPresentationController!.delegate = self;
        self.preferredContentSize = CGSizeMake(200, 200)
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: CellIdentifier)
        }
        cell?.textLabel?.text = options[indexPath.row]
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.delegate?.didSelectOption(indexPath.row)
    }

}
