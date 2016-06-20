//
//  CalculatorViewController.swift
//  Maxus
//
//  Created by Balram Singh on 16/05/16.
//  Copyright © 2016 Balram Singh. All rights reserved.
//

import UIKit

class CalculatorViewController: PopoverViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    var textField: UIView? = nil
    private var originalFrame: CGRect? = nil

    @IBOutlet weak var menuButton: UIButton!
    
    @IBOutlet weak var firstTF: UITextField!
    @IBOutlet weak var secondTF: UITextField!
    @IBOutlet weak var thirdTF: UITextField!
    @IBOutlet weak var fourthTF: UITextField!
    
    @IBOutlet weak var overlayContainerView: UIView!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var calculateButton: UIButton!
    var options1 = ["Other",
    "Physician",
    "Dentist",
    "Chiropractor",
    "Osteopaths",
    "Other licensed practitioner of the healing arts",
    "Attorneys at Law",
    "Public Accountants",
    "Public Engineers",
    "Architects",
    "Draftsmen",
    "Actuaries",
    "Psychologists",
    "Social or Physical Scientists",
    "Performing Arts"]
    
    var options2 = ["None", "1-25", "26 or More"]
    
    var options3 : [String] = []
    var options4 : [String] = []
    
    lazy var pgArray : [NSDictionary] = {
        if let path = NSBundle.mainBundle().pathForResource("PG", ofType: "json") {
            do {
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                do {
                    let jsonResult: [NSDictionary] = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! [NSDictionary]
                    return jsonResult
                    
                } catch {}
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path PG")
        }
        return []
    }()
    
    lazy var nonPGArray : [NSDictionary] = {
        if let path = NSBundle.mainBundle().pathForResource("Non-PG", ofType: "json") {
            do {
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                do {
                    let jsonResult: [NSDictionary] = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! [NSDictionary]
                    return jsonResult
                    
                } catch {}
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path for NOn-PG")
        }
        return []
    }()
    
    var formatter : NSNumberFormatter {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.currencyCode = "USD"
        return formatter
    }
    private var option1Index = -1
    private var option2Index = -1
    private var option3Index = -1
    private var option4Index = -1
    
    private var result : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.calculateButton.layer.cornerRadius = 10.0
        self.firstTF.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.firstTF.layer.borderWidth = 1.0
        
        let pickerView1 = UIPickerView()
        pickerView1.delegate = self
        pickerView1.dataSource = self
        pickerView1.tag = 1
        firstTF.inputView = pickerView1
        firstTF.inputAccessoryView = toolBar(1)
        let frame = CGRectMake(0, 0, 10, self.firstTF.frame.size.height)
        let leftView1 = UIView(frame:  frame)
        firstTF.leftView = leftView1
        firstTF.leftViewMode = .Always

        
        
        self.secondTF.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.secondTF.layer.borderWidth = 1.0
        
        let pickerView2 = UIPickerView()
        pickerView2.delegate = self
        pickerView2.dataSource = self
        pickerView2.tag = 2
        secondTF.inputView = pickerView2
        secondTF.inputAccessoryView =  toolBar(2)
        let leftView2 = UIView(frame:  frame)
        secondTF.leftView = leftView2
        secondTF.leftViewMode = .Always
        
        self.thirdTF.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.thirdTF.layer.borderWidth = 1.0
        let pickerView3 = UIPickerView()
        pickerView3.delegate = self
        pickerView3.dataSource = self
        pickerView3.tag = 3
        thirdTF.inputView = pickerView3
        thirdTF.inputAccessoryView = toolBar(3)
        let leftView3 = UIView(frame:  frame)
        thirdTF.leftView = leftView3
        thirdTF.leftViewMode = .Always

        
        self.fourthTF.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.fourthTF.layer.borderWidth = 1.0
        let pickerView4 = UIPickerView()
        pickerView4.delegate = self
        pickerView4.dataSource = self
        pickerView4.tag = 4
        fourthTF.inputView = pickerView4
        fourthTF.inputAccessoryView = toolBar(4)
        let leftView4 = UIView(frame:  frame)
        fourthTF.leftView = leftView4
        fourthTF.leftViewMode = .Always
        
        for age in 30...90 {
            self.options3.append(String(format: "%d", age))
        }
        options4 = getSalaryOptions()
        
        self.overlayContainerView.layer.cornerRadius = 10
        
    }
    
    override func viewDidAppear(animated: Bool) {
        self.originalFrame = self.view.frame
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func hideOverlay(sender: AnyObject) {
        self.overlayView.hidden = true
    }
    
    @IBOutlet weak var hide: UIButton!
    @IBAction func showInfo(sender: AnyObject) {
        self.overlayView.hidden = false
        
    }
    @IBAction func calculate(sender: AnyObject) {
        if option1Index == -1 || option2Index == -1 || option3Index == -1 || option4Index == -1 {
            let alertController = UIAlertController(title: "Invalid inputs", message: "Please select proper options", preferredStyle: .Alert)
            let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alertController.addAction(action)
            self.presentViewController(alertController, animated: true, completion: nil)
        } else {
            calculateResult ()
            let resultVC = self.storyboard?.instantiateViewControllerWithIdentifier("ResultVC") as! ResultViewController
            resultVC.result = result
            self.navigationController?.pushViewController(resultVC, animated: true)
        }
    }
   

    @IBAction func menuButtonClicked(sender: UIButton) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    @IBAction func backPressed(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    func getSalaryOptions () -> [String] {
        if let path = NSBundle.mainBundle().pathForResource("PG", ofType: "json") {
            do {
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                do {
                    let jsonResult: NSArray = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSArray
                    if let salaries : NSDictionary = jsonResult[0] as? NSDictionary {
                        let allKeys  =  salaries.allKeys as! [String]
                        
                        return allKeys.sort {
                            var plainString1 = $0.stringByReplacingOccurrencesOfString(" ", withString: "")
                            plainString1 = plainString1.stringByReplacingOccurrencesOfString(",", withString: "")
                            let string = NSString(string: plainString1)
                            
                            var plainString2 = $1.stringByReplacingOccurrencesOfString(" ", withString: "")
                            plainString2 = plainString2.stringByReplacingOccurrencesOfString(",", withString: "")
                            
                            let string2 = NSString(string: plainString2)
                            
                            return string.doubleValue < string2.doubleValue
                            }
                    }
                } catch {}
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }
        return []
    }
    
    //MARK: UIPickerViewDataSource
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
             return options1.count
        case 2:
            return options2.count
        case 3:
            return options3.count
        case 4:
            
            
            return options4.count
        default:
            return 0
            
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return options1[row]
        case 2:
            return options2[row]
        case 3:
            return options3[row]
        case 4:
            let currency =  getCurrencyFormatOfString(options4[row])
            return currency
        default:
            return ""
        }
    }
    
    //MARK: UIPickerViewDlegate 
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            option1Index = row
            self.firstTF.text = options1[row]
        case 2:
            option2Index = row
            self.secondTF.text = options2[row]
        case 3:
            option3Index = row
            self.thirdTF.text = options3[row]
        case 4:
            option4Index = row
            self.fourthTF.text = getCurrencyFormatOfString(options4[row])
        default:
            print("How is this possible?")
        }
    }
    
    func done(doneButton : UIBarButtonSystemItem) {
        if firstTF.isFirstResponder() {
            if firstTF.text == "" {
                self.makeDefaultSelection(firstTF)
            }
            firstTF.resignFirstResponder()
        } else if secondTF.isFirstResponder() {
            if secondTF.text == "" {
                self.makeDefaultSelection(secondTF)
            }
            secondTF.resignFirstResponder()
        } else if thirdTF.isFirstResponder() {
            if thirdTF.text == "" {
                self.makeDefaultSelection(thirdTF)
            }
            thirdTF.resignFirstResponder()
        } else if fourthTF.isFirstResponder() {
            if fourthTF.text == "" {
                self.makeDefaultSelection(fourthTF)
            }
            fourthTF.resignFirstResponder()
        }
    }
    
    
    func toolBar(textFieldIndex : Int) -> UIToolbar {
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: #selector(CalculatorViewController.done))
        doneButton.tag = textFieldIndex
        
        let buttonPrevious =  UIBarButtonItem(title: "Prev", style: .Plain, target: self, action: #selector(self.goToPrevious))
        buttonPrevious.tag = textFieldIndex
        let nextButton =  UIBarButtonItem(title: "Next", style: .Plain, target: self, action: #selector(self.next))
        nextButton.tag = textFieldIndex
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        
        
        let toolBar = UIToolbar(frame: CGRectMake(0, 0, self.view.frame.size.width, 44))
        switch textFieldIndex {
        case 1:
            toolBar.items = [nextButton, flexibleSpace, doneButton]
            break
        case 2:
            toolBar.items = [buttonPrevious, nextButton, flexibleSpace, doneButton]
            break
        case 3:
            toolBar.items = [buttonPrevious, nextButton, flexibleSpace, doneButton]
            break
        case 4:
            toolBar.items = [buttonPrevious, flexibleSpace, doneButton]
            break
        default:
            break
        }
        return toolBar
    }
    
    func next (barButton : UIBarButtonItem) {
        switch barButton.tag {
        case 1:
            if firstTF.text == "" {
                self.makeDefaultSelection(firstTF)
            }
            secondTF.becomeFirstResponder()
            break
        case 2:
            if secondTF.text == "" {
                self.makeDefaultSelection(secondTF)
            }
            thirdTF.becomeFirstResponder()
            break
        case 3:
            if thirdTF.text == "" {
                self.makeDefaultSelection(thirdTF)
            }
            fourthTF.becomeFirstResponder()
            break
        default:
            break
        }
    }
    
    func goToPrevious(barButton : UIBarButtonItem) {
        switch barButton.tag {
        case 2:
            if secondTF.text == "" {
                self.makeDefaultSelection(secondTF)
            }
            firstTF.becomeFirstResponder()
            break
        case 3:
            if thirdTF.text == "" {
                self.makeDefaultSelection(thirdTF)
            }
            secondTF.becomeFirstResponder()
            break
        case 4:
            if fourthTF.text == "" {
                self.makeDefaultSelection(fourthTF)
            }
            thirdTF.becomeFirstResponder()
            break
        default:
            break
        }
    }
    
    func makeDefaultSelection (textField : UITextField) {
        let picker =  textField.inputView as? UIPickerView
        picker?.selectRow(0, inComponent: 0, animated: false)
        self.pickerView(picker!, didSelectRow: 0, inComponent: 0)
    }
    
    func calculateResult () {
        var selectedArrayList : [NSDictionary]?
        if option2Index == 0 {
            //use non
            selectedArrayList = nonPGArray
        } else if option2Index == 1  && option1Index > 0 {
            //use non
            selectedArrayList = nonPGArray
        } else if option2Index == 2 {
            //use non
            selectedArrayList = nonPGArray
        } else if option2Index == 1 && option1Index == 0 {
            //use pg
            selectedArrayList = pgArray
        }
    
        if let list = selectedArrayList {
            let dict : NSDictionary =  list[option3Index]
            let key = options4[option4Index]
            result = dict.objectForKey(key) as? String
        }
    }
    
    func getCurrencyFormatOfString  (text : String) -> String {
        var plainString = text.stringByReplacingOccurrencesOfString(" ", withString: "")
        plainString = plainString.stringByReplacingOccurrencesOfString(",", withString: "")
        let string = NSString(string: plainString)
        let convertPrice = NSNumber(double: string.doubleValue)
        let convertedPrice = formatter.stringFromNumber(convertPrice)
        return convertedPrice!
        
    }
    @IBAction func showMenu(sender: AnyObject) {
        self.showPopover(self.menuButton)
        
    }
    
    //MARK: UITextFieldDelegate
    func textFieldDidBeginEditing(textField: UITextField) {
        self.textField = textField
        self.keyboardShown()

    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        keyboardHidden()
    }
    
    
    func keyboardShown() {
        let rawFrame = UIPickerView().frame
        let keyboardFrame = view.convertRect(rawFrame, fromView: nil)
        
        let movementDuration = 0.1;
        
        if let field = self.textField {
            let frame = view.convertRect(field.frame, fromView: field.superview)
            let viewFrame = self.view.frame
            if CGRectGetMaxY(frame) > viewFrame.size.height - keyboardFrame.size.height {
                let movement = -(CGRectGetMaxY(frame) - (viewFrame.size.height - keyboardFrame.size.height) + 50)
                
                UIView.beginAnimations("anim", context: nil)
                UIView.setAnimationBeginsFromCurrentState(true)
                UIView.setAnimationDuration(movementDuration)
                self.view.frame = CGRectOffset(self.view.frame, 0, movement);
                UIView.commitAnimations();
            }
        }
    }
    
    func keyboardHidden() {
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
}
