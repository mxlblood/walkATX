//
//  AccountViewController.swift
//  walkATX
//
//  Created by Maximilian Blood on 4/24/18.
//  Copyright © 2018 Maximilian Blood. All rights reserved.
//

import UIKit

var firstName : String = ""
var lastName : String = ""
var addLine1 : String = ""
var addLine2 : String = ""
var city : String = ""
var state : String = ""
var zipcode : String = ""
var phoneNumber : String = ""
var emergencyName : String = ""
var emergencyPhone : String = ""
var password : String = ""

class AccountViewController: UIViewController {
    //var dataList : NSArray = []

    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtAddLine1: UITextField!
    @IBOutlet weak var txtAddLine2: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtZip: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtEmergencyName: UITextField!
    @IBOutlet weak var txtEmergencyPhone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBAction func btnUpdate(_ sender: UIButton) {
        let request = NSMutableURLRequest(url: NSURL(string: "https://mblood2.create.stedwards.edu/walkATX/updateAccount.php")! as URL)
        request.httpMethod = "POST"
        let postString = "a=\(txtFirstName.text!)&b=\(txtLastName.text!)&c=\(txtAddLine1.text!)&d=\(txtAddLine2.text!)&e=\(txtCity.text!)&f=\(txtState.text!)&g=\(txtZip.text!)&h=\(txtPhone.text!)&i=\(txtEmergencyName.text!)&j=\(txtEmergencyPhone.text!)&k=\(txtEmail.text!)"
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
                    let alertController = UIAlertController(title: "Success!", message: "Account successfully updated.", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil))
                    self.present(alertController, animated: true, completion: nil)
                }// end if
                    
                else {
                    let alertController = UIAlertController(title: "Error", message: "Account could not be updated at this time.", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil))
                    self.present(alertController, animated: true, completion: nil)
                }//end else
            }// end dispatch queue sync
            
        }//end of task
        task.resume() // means run task
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(email)
        getData()
        if(dataList.count == 0){return}
        else{
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
        
        txtFirstName.text = firstName
        txtLastName.text = lastName
        txtAddLine1.text = addLine1
        txtAddLine2.text = addLine2
        txtCity.text = city
        txtState.text = state
        txtZip.text = zipcode
        txtPhone.text = phoneNumber
        txtEmergencyName.text = emergencyName
        txtEmergencyPhone.text = emergencyPhone
        txtEmail.text = email
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                if(dataList.count == 0) {return}
                else{
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
                    
                    self.txtFirstName.text = firstName
                    self.txtLastName.text = lastName
                    self.txtAddLine1.text = addLine1
                    self.txtAddLine2.text = addLine2
                    self.txtCity.text = city
                    self.txtState.text = state
                    self.txtZip.text = zipcode
                    self.txtPhone.text = phoneNumber
                    self.txtEmergencyName.text = emergencyName
                    self.txtEmergencyPhone.text = emergencyPhone
                    self.txtEmail.text = email
                }
            }
            
        }//end of task
        task.resume() // means run task
    }


}
