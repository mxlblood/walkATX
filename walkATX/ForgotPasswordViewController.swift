//
//  ForgotPasswordViewController.swift
//  walkATX
//
//  Created by Maximilian Blood on 4/23/18.
//  Copyright © 2018 Maximilian Blood. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    
    @IBAction func btnSubmit(_ sender: UIButton) {
        if ( (txtUsername.text == "") ) {
            let alertController = UIAlertController(title: "Empty Fields Detected", message: "Email address cannot be blank.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        else {
            // put the link of the php file here. The php file connects the mysql and swift
            let request = NSMutableURLRequest(url: NSURL(string: "https://mblood2.create.stedwards.edu/walkATX/forgot.php")! as URL)
            request.httpMethod = "POST"
            let postString = "a=\(txtUsername.text!)"
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
                        let alertController = UIAlertController(title: "Check Email", message: "Instructions on how to reset password sent to email.", preferredStyle: UIAlertControllerStyle.alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil))
                        self.present(alertController, animated: true, completion: nil)
                    }// end if
                        
                    else {
                        let alertController = UIAlertController(title: "Error", message: "Email not found in database.", preferredStyle: UIAlertControllerStyle.alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil))
                        self.present(alertController, animated: true, completion: nil)
                    }//end else
                    
                    self.txtUsername.text = ""
                    
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
