//
//  AddPaymentViewController.swift
//  walkATX
//
//  Created by Maximilian Blood on 4/24/18.
//  Copyright © 2018 Maximilian Blood. All rights reserved.
//

import UIKit

class AddPaymentViewController: UIViewController {

    @IBOutlet weak var txtCardName: UITextField!
    @IBOutlet weak var txtCreditCardNum: UITextField!
    @IBOutlet weak var txtExpDate: UITextField!
    @IBOutlet weak var txtSecurityCode: UITextField!
    @IBOutlet weak var txtBillingAddres: UITextField!
    @IBOutlet weak var txtZip: UITextField!
    @IBAction func btnAddPayment(_ sender: UIButton) {
        if ( (txtCardName.text == "") || (txtCreditCardNum.text == "" ) || (txtExpDate.text == "") || (txtSecurityCode.text == "") || (txtBillingAddres.text == "" ) || (txtZip.text == "") ) {
            let alertController = UIAlertController(title: "Empty Fields Detected", message: "Please make sure all information is filled out.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        else{
            // put the link of the php file here. The php file connects the mysql and swift
            let request = NSMutableURLRequest(url: NSURL(string: "https://mblood2.create.stedwards.edu/walkATX/addCredit.php")! as URL)
            request.httpMethod = "POST"
            let postString = "a=\(txtCardName.text!)&b=\(txtCreditCardNum.text!)&c=\(txtExpDate.text!)&d=\(txtSecurityCode.text!)&e=\(txtBillingAddres.text!)&f=\(txtZip.text!)&g=\(email)"
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
                        let alertController = UIAlertController(title: "Success", message: "Credit card added successfully.", preferredStyle: UIAlertControllerStyle.alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil))
                        self.present(alertController, animated: true, completion: nil)
                    }// end if
                        
                    else {
                        let alertController = UIAlertController(title: "Error", message: "Credit card could not be added at this time.", preferredStyle: UIAlertControllerStyle.alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil))
                        self.present(alertController, animated: true, completion: nil)
                    }//end else
                    
                    self.txtCardName.text = ""
                    self.txtExpDate.text = ""
                    self.txtCreditCardNum.text = ""
                    self.txtExpDate.text = ""
                    self.txtSecurityCode.text = ""
                    self.txtBillingAddres.text = ""
                    self.txtZip.text = ""
                    
                }// end dispatch queue sync
                
                
            }//end of task
            task.resume() // means run task
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //need to update page so keyboard dissapears
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

}
