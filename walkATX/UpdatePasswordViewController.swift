//
//  UpdatePasswordViewController.swift
//  walkATX
//
//  Created by Maximilian Blood on 4/30/18.
//  Copyright © 2018 Maximilian Blood. All rights reserved.
//

import UIKit

class UpdatePasswordViewController: UIViewController {

    @IBOutlet weak var txtOldPass: UITextField!
    @IBOutlet weak var txtNewPass: UITextField!
    @IBOutlet weak var txtRePass: UITextField!
    @IBAction func btnUpdatePass(_ sender: UIButton) {
        if (txtOldPass.text != password){
            let alertController = UIAlertController(title: "Error", message: "Password did not match password on file.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        else if ( (txtNewPass.text == "") || (txtRePass.text == "" )  ) {
            let alertController = UIAlertController(title: "Empty Fields Detected", message: "Password cannot be blank.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        else if (txtNewPass.text != txtRePass.text) {
            let alertController = UIAlertController(title: "Error", message: "Passwords do not match.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        let request = NSMutableURLRequest(url: NSURL(string: "https://mblood2.create.stedwards.edu/walkATX/updatePassword.php")! as URL)
        request.httpMethod = "POST"
        let postString = "a=\(email)&b=\(txtNewPass.text!)"
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
                    let alertController = UIAlertController(title: "Success!", message: "Password successfully updated.", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil))
                    self.present(alertController, animated: true, completion: nil)
                    self.getData()
                }// end if
                    
                else {
                    let alertController = UIAlertController(title: "Error", message: "Password could not be updated at this time.", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil))
                    self.present(alertController, animated: true, completion: nil)
                }//end else
            }// end dispatch queue sync
            
        }//end of task
        task.resume() // means run task
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
    
    func getData() {
        //dataList=[]
        let request = NSMutableURLRequest(url: NSURL(string: "https://mblood2.create.stedwards.edu/walkATX/getData.php")! as URL)
        request.httpMethod = "POST"
        let postString = "a=\(email)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil {
                print ("error=\(error!)")
                return
            }
            print ("response =\(response!)")
            dataList = try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
            DispatchQueue.main.async {
                print(dataList)
                let mainData = dataList[0] as? [String:Any]
                firstName = (mainData?["firstName"] as? String)!
                lastName = (mainData?["lastName"] as? String)!
                addLine1 = (mainData?["addLine1"] as? String)!
                addLine2 = (mainData?["addLine2"] as? String)!
                city = (mainData?["city"] as? String)!
                state = (mainData?["state"] as? String)!
                zipcode = (mainData?["zipcode"] as? String)!
                phoneNumber = (mainData?["phoneNumber"] as? String)!
                emergencyName = (mainData?["emergencyName"] as? String)!
                emergencyPhone = (mainData?["emergencyPhone"] as? String)!
                password = (mainData?["password"] as? String)!
                
                self.txtOldPass.text = ""
                self.txtRePass.text = ""
                self.txtNewPass.text = ""
                
            }
            
        }//end of task
        task.resume() // means run task
    }
    

}
