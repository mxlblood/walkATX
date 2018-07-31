//
//  LoginViewController.swift
//  walkATX
//
//  Created by Maximilian Blood on 4/23/18.
//  Copyright © 2018 Maximilian Blood. All rights reserved.
//

import UIKit

var email : String = ""

class LoginViewController: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBAction func btnLogin(_ sender: UIButton) {
        if ( (txtUsername.text == "") || (txtPassword.text == "" )  ) {
            let alertController = UIAlertController(title: "Empty Fields Detected", message: "Username and password cannot be blank.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        else {
            // put the link of the php file here. The php file connects the mysql and swift
            let request = NSMutableURLRequest(url: NSURL(string: "https://mblood2.create.stedwards.edu/walkATX/login.php")! as URL)
            request.httpMethod = "POST"
            let postString = "a=\(txtUsername.text!)&b=\(txtPassword.text!)"
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
                        email = self.txtUsername.text!
                        let alertController = UIAlertController(title: "Success!", message: "Log In Successful", preferredStyle: UIAlertControllerStyle.alert)
                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (alertController) in
                            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "tabVC") as! UITabBarController
                            //self.present(nextViewController, animated: true, completion: nil)
                            self.present(nextViewController, animated: true, completion: nil)
                        })
                        
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                        
                        
                    }// end if
                        
                    else {
                        let alertController = UIAlertController(title: "Error", message: "Username and password combination not recognized.", preferredStyle: UIAlertControllerStyle.alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil))
                        self.present(alertController, animated: true, completion: nil)
                    }//end else
                    
                    self.txtUsername.text = ""
                    self.txtPassword.text = ""
                    
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
