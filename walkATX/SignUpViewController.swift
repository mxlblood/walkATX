//
//  SignUpViewController.swift
//  walkATX
//
//  Created by Maximilian Blood on 4/23/18.
//  Copyright © 2018 Maximilian Blood. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtAddLine1: UITextField!
    @IBOutlet weak var txtAddLine2: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtZip: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtEmergName: UITextField!
    @IBOutlet weak var txtEmergPhone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtRePassword: UITextField!
    

    @IBAction func btnRegister(_ sender: UIButton) {
        if ( (txtFirstName.text == "") || (txtLastName.text == "" ) || (txtAddLine1.text == "") || (txtCity.text == "") || (txtState.text == "" ) || (txtZip.text == "") || (txtPhone.text == "" ) || (txtEmergName.text == "") || (txtEmergPhone.text == "" ) || (txtEmail.text == "") || (txtPassword.text == "" ) || (txtRePassword.text == "" ) ) {
            let alertController = UIAlertController(title: "Empty Fields Detected", message: "Please make sure all information is filled out.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        else if (txtPassword.text != txtRePassword.text) {
            let alertController = UIAlertController(title: "Error", message: "Passwords do not match.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        else{
            // put the link of the php file here. The php file connects the mysql and swift
            let request = NSMutableURLRequest(url: NSURL(string: "https://mblood2.create.stedwards.edu/walkATX/insertClient.php")! as URL)
            request.httpMethod = "POST"
            let postString = "a=\(txtFirstName.text!)&b=\(txtLastName.text!)&c=\(txtAddLine1.text!)&d=\(txtAddLine2.text!)&e=\(txtCity.text!)&f=\(txtState.text!)&g=\(txtZip.text!)&h=\(txtPhone.text!)&i=\(txtEmergName.text!)&j=\(txtEmergPhone.text!)&k=\(txtEmail.text!)&l=\(txtPassword.text!)"
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
                        email = self.txtEmail.text!
                        let alertController = UIAlertController(title: "Account successfully added", message: "Welcome to the pack!", preferredStyle: UIAlertControllerStyle.alert)
                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (alertController) in
                            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "registerPetVC") as! RegisterPetViewController
                            //self.present(nextViewController, animated: true, completion: nil)
                            self.present(nextViewController, animated: true, completion: nil)
                        })
                        
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                    }// end if
                        
                    else {
                        let alertController = UIAlertController(title: "Cannot Create New Account", message: "Email already on file", preferredStyle: UIAlertControllerStyle.alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil))
                        self.present(alertController, animated: true, completion: nil)
                    }//end else
                    
                    self.txtFirstName.text = ""
                    self.txtLastName.text = ""
                    self.txtAddLine1.text = ""
                    self.txtAddLine2.text = ""
                    self.txtCity.text = ""
                    self.txtState.text = ""
                    self.txtZip.text = ""
                    self.txtPhone.text = ""
                    self.txtEmergName.text = ""
                    self.txtEmergPhone.text = ""
                    self.txtEmail.text = ""
                    self.txtPassword.text = ""
                    self.txtRePassword.text = ""
                    
                }// end dispatch queue sync
                
                
            }//end of task
            task.resume() // means run task
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
