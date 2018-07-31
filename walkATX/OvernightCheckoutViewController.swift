//
//  OvernightCheckoutViewController.swift
//  walkATX
//
//  Created by Maximilian Blood on 4/23/18.
//  Copyright © 2018 Maximilian Blood. All rights reserved.
//

import UIKit

class OvernightCheckoutViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    var OCPickerIndex = 0
    //var button = dropDownBtn()
    //let credList = ["1111-2222-3333-4444", "2222-3333-5555-6666", "2222-3333-4444-5555"]
    var price : Int = 0
    
    @IBOutlet weak var overnightPicker: UIPickerView!
    @IBOutlet weak var lblDates: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBAction func btnContinue(_ sender: UIButton) {
        /*
        if (creditCardIndex == -1){
            let alertController = UIAlertController(title: "Error", message: "Please select a credit card to use.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil))
            self.present(alertController, animated: true, completion: nil)
            return
        }
         */
        let request = NSMutableURLRequest(url: NSURL(string: "https://mblood2.create.stedwards.edu/walkATX/addOvernight.php")! as URL)
        request.httpMethod = "POST"
        print("ocPickerIndex\(OCPickerIndex)")
        let mainData = credList[OCPickerIndex] as? [String:Any]
        let creditCardNum = (mainData?["creditCard"] as? String)!
        let postString = "a=\(overnightStart)&b=\(overnightEnd)&c=\(price)&d=\(creditCardNum)&e=\(email)"
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
            DispatchQueue.main.async() {
                if (responseString! == "Success") {
                    let alertController = UIAlertController(title: "Success!", message: "Overnight successfully scheduled.", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil))
                    self.present(alertController, animated: true, completion: nil)
                }// end if
                    
                else {
                    let alertController = UIAlertController(title: "Error", message: "Overnight could not be scheduled at this time.", preferredStyle: UIAlertControllerStyle.alert)
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
        let difference = userCalendar.dateComponents([.day], from: overnightStart, to: overnightEnd)
        diff = difference.day!
        print(diff)
        
        self.lblDates.text = ("\(overnightStartDate) - \(overnightEndDate)")
        self.price = 45*diff
        self.lblPrice.text = " $\(self.price).00"
        
        print(diff)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        var diff : Int = 0
        
        let userCalendar = NSCalendar.current
        let difference = userCalendar.dateComponents([.day], from: overnightStart, to: overnightEnd)
        diff = difference.day!
        print(diff)
        
        self.lblDates.text = ("\(overnightStartDate) - \(overnightEndDate)")
        self.price = 45*diff
        self.lblPrice.text = " $\(self.price).00"
        
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
        OCPickerIndex = row
    }

}


