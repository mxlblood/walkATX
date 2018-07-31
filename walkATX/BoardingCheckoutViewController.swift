//
//  BoardingCheckoutViewController.swift
//  walkATX
//
//  Created by Maximilian Blood on 4/23/18.
//  Copyright © 2018 Maximilian Blood. All rights reserved.
//

import UIKit

class BoardingCheckoutViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    //var button = dropDownBtn()
    //let credList = ["1111-2222-3333-4444", "2222-3333-5555-6666", "2222-3333-4444-5555"]
    //var credList = NSArray()
    var price : Int = 0
    var BCPickerIndex = -1
    
    @IBOutlet weak var boardingPicker: UIPickerView!
    @IBOutlet weak var lblDates: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBAction func btnContinue(_ sender: UIButton) {
        if (BCPickerIndex == -1){
            let alertController = UIAlertController(title: "Error", message: "Please select a credit card to use.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        let request = NSMutableURLRequest(url: NSURL(string: "https://mblood2.create.stedwards.edu/walkATX/addBoarding.php")! as URL)
        request.httpMethod = "POST"
        let mainData = credList[BCPickerIndex] as? [String:Any]
        let creditCardNum = (mainData?["creditCard"] as? String)!
        let postString = "a=\(bsd)&b=\(bed)&c=\(price)&d=\(creditCardNum)&e=\(email)"
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
                    let alertController = UIAlertController(title: "Success!", message: "Boarding successfully scheduled.", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil))
                    self.present(alertController, animated: true, completion: nil)
                }// end if
                    
                else {
                    let alertController = UIAlertController(title: "Error", message: "Boarding could not be scheduled at this time.", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil))
                    self.present(alertController, animated: true, completion: nil)
                }//end else
            }// end dispatch queue sync
            
        }//end of task
        task.resume() // means run task
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //creditCardIndex = -1
        
        var diff : Int = 0
        
        let userCalendar = NSCalendar.current
        let difference = userCalendar.dateComponents([.day], from: bsd, to: bed)
        diff = difference.day!
        print(diff)
        
        lblDates.text = ("\(boardingStartDate) - \(boardingEndDate)")
        price = 45*diff
        lblPrice.text = " $\(price).00"
        
        print(diff)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        var diff : Int = 0
        
        let userCalendar = NSCalendar.current
        let difference = userCalendar.dateComponents([.day], from: bsd, to: bed)
        diff = difference.day!
        print(diff)
        
        lblDates.text = ("\(boardingStartDate) - \(boardingEndDate)")
        price = 45*diff
        lblPrice.text = " $\(price).00"
        
        print(diff)
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
        let mainData = credList[row] as? [String:Any]
        let creditCardNum = (mainData?["creditCard"] as? String)!
        return creditCardNum
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        BCPickerIndex = row
    }
    
    
}


