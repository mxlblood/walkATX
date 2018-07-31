//
//  WalkCheckoutViewController.swift
//  walkATX
//
//  Created by Maximilian Blood on 4/23/18.
//  Copyright © 2018 Maximilian Blood. All rights reserved.
//

import UIKit

//var creditCardIndex : Int = -1

class WalkCheckoutViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //var button = dropDownBtn()
    let surcharge : Float = 5.0
    var price : Float = 0.0
    var walkCCIndex = 0
    //let credList = ["1111-2222-3333-4444", "2222-3333-5555-6666", "2222-3333-4444-5555"]
    //var credList = NSArray()
    
    @IBOutlet weak var walkPicker: UIPickerView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblLength: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBAction func btnContinue(_ sender: UIButton) {
        if (walkCCIndex == -1){
            let alertController = UIAlertController(title: "Error", message: "Please select a credit card to use.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        let request = NSMutableURLRequest(url: NSURL(string: "https://mblood2.create.stedwards.edu/walkATX/addWalk.php")! as URL)
        request.httpMethod = "POST"
        let mainData = credList[walkCCIndex] as? [String:Any]
        let creditCardNum = (mainData?["creditCard"] as? String)!
        let postString = "a=\(walkStartDate)&b=\(startWalkTime)&c=\(endWalkTime)&d=\(timeType)&e=\(walkType)&f=\(price)&g=\(email)&h=\(creditCardNum)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil {
                print ("error=\(error!)")
                return
            }
            print ("response =\(response!)")
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(responseString!)")
            
            //makes sure previous lines have run before continuing
            DispatchQueue.main.async() {
                //check if username already exists, mysql will throw an error in case of duplicate keys
                if (responseString! == "Success") {
                    let alertController = UIAlertController(title: "Success!", message: "Walk successfully scheduled.", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil))
                    self.present(alertController, animated: true, completion: nil)
                }// end if
                    
                else {
                    let alertController = UIAlertController(title: "Error", message: "Walk could not be scheduled at this time.", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil))
                    self.present(alertController, animated: true, completion: nil)
                }//end else
            }// end dispatch queue sync
        }//end of task
        task.resume() // means run task
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //getData()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        let startDate = dateFormatter.string(from: walkStartDate)
        lblDate.text = "Date: \(startDate)"
        
        let calendar = Calendar.current
        let startComponents = calendar.dateComponents([.hour, .minute], from: startWalkTime)
        var startHour = startComponents.hour!
        if (startHour == 0){
            startHour = 12
        }
        let startMin = startComponents.minute!
        
        let endComponents = calendar.dateComponents([.hour, .minute], from: endWalkTime)
        var endHour = endComponents.hour!
        if (endHour == 0){
            endHour = 12
        }
        let endMin = endComponents.minute!
        
        lblTime.text = "Time: \(startHour):\(startMin) to \(endHour):\(endMin)"
        if (timeType == 1){
            lblType.text = "Type: One Time"
            //timeType = "One Time"
        }
        else if (timeType == 2){
            lblType.text = "Type: Weekly"
            //timeType = "Weekly"
            
        }
        if (walkType == 1){
            lblLength.text = "Length of Walk: Let Out"
            if (lateWalk == 1){
                price = 16.00 + surcharge
                lblPrice.text = " $\(price)0"
            }
            else if (lateWalk == 0){
                price = 16.00
                lblPrice.text = " $\(price)0"
            }
        }
        else if (walkType == 2){
            lblLength.text = "Length of Walk: 30 minutes"
            if (lateWalk == 1){
                price = 20.00 + surcharge
                lblPrice.text = " $\(price)0"
            }
            else if (lateWalk == 0){
                price = 20.00
                lblPrice.text = " $\(price)0"
            }
        }
        else if (walkType == 3){
            lblLength.text = "Length of Walk: 1 hour"
            if (lateWalk == 1){
                price = 34.00 + surcharge
                lblPrice.text = " $\(price)0"
            }
            else if (lateWalk == 0){
                price = 34.00
                lblPrice.text = " $\(price)0"
            }
        }
        else if (walkType == 4){
            lblLength.text = "Length of Walk: 2+ hour hike"
            if (lateWalk == 1){
                price = 45.00 + surcharge
                lblPrice.text = " $\(price)0"
            }
            else if (lateWalk == 0){
                price = 45.00
                lblPrice.text = " $\(price)0"
            }
        }
        
        //var lastMinute : Int = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        let startDate = dateFormatter.string(from: walkStartDate)
        lblDate.text = "Date: \(startDate)"
        
        let calendar = Calendar.current
        let startComponents = calendar.dateComponents([.hour, .minute], from: startWalkTime)
        var startHour = startComponents.hour!
        if (startHour == 0){
            startHour = 12
        }
        let startMin = startComponents.minute!
        
        let endComponents = calendar.dateComponents([.hour, .minute], from: endWalkTime)
        var endHour = endComponents.hour!
        if (endHour == 0){
            endHour = 12
        }
        let endMin = endComponents.minute!
        
        lblTime.text = "Time: \(startHour):\(startMin) to \(endHour):\(endMin)"
        if (timeType == 1){
            lblType.text = "Type: One Time"
            //timeType = "One Time"
        }
        else if (timeType == 2){
            lblType.text = "Type: Weekly"
            //timeType = "Weekly"
            
        }
        if (walkType == 1){
            lblLength.text = "Length of Walk: Let Out"
            if (lateWalk == 1){
                price = 16.00 + surcharge
                lblPrice.text = " $\(price)0"
            }
            else if (lateWalk == 0){
                price = 16.00
                lblPrice.text = " $\(price)0"
            }
        }
        else if (walkType == 2){
            lblLength.text = "Length of Walk: 30 minutes"
            if (lateWalk == 1){
                price = 20.00 + surcharge
                lblPrice.text = " $\(price)0"
            }
            else if (lateWalk == 0){
                price = 20.00
                lblPrice.text = " $\(price)0"
            }
        }
        else if (walkType == 3){
            lblLength.text = "Length of Walk: 1 hour"
            if (lateWalk == 1){
                price = 34.00 + surcharge
                lblPrice.text = " $\(price)0"
            }
            else if (lateWalk == 0){
                price = 34.00
                lblPrice.text = " $\(price)0"
            }
        }
        else if (walkType == 4){
            lblLength.text = "Length of Walk: 2+ hour hike"
            if (lateWalk == 1){
                price = 45.00 + surcharge
                lblPrice.text = " $\(price)0"
            }
            else if (lateWalk == 0){
                price = 45.00
                lblPrice.text = " $\(price)0"
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return credList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //return credList[row] as? String
        let mainData = credList[row] as? [String:Any]
        let creditCardNum = (mainData?["creditCard"] as? String)!
        return creditCardNum
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        walkCCIndex = row
    }

}

