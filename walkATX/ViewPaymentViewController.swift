//
//  ViewPaymentViewController.swift
//  walkATX
//
//  Created by Maximilian Blood on 4/24/18.
//  Copyright © 2018 Maximilian Blood. All rights reserved.
//

import UIKit

var cred : String = ""
var stringCredList : [String] = []

class ViewPaymentViewController: UIViewController {

    var button = dropDownBtn()
    //var credList = ["1111-2222-3333-4444", "2222-3333-5555-6666", "2222-3333-4444-5555"]
    var credList = NSArray()
    var credNum : Int = 0
    
    @IBAction func btnRemove(_ sender: UIButton) {
        if (creditCardIndex == -1){
            let alertController = UIAlertController(title: "Error", message: "Please select a credit card to remove.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil))
            self.present(alertController, animated: true, completion: nil)
            getData()
            return
        }
        //credNum = Int(stringCredList[creditCardIndex])!
        let mainData = credList[creditCardIndex] as? [String:Any]
        let creditCardNum = (mainData?["creditCard"] as? String)!
        print(creditCardNum)
        let request = NSMutableURLRequest(url: NSURL(string: "https://mblood2.create.stedwards.edu/walkATX/removeCredit.php")! as URL)
        request.httpMethod = "POST"
        let postString = "a=\(creditCardNum)&b=\(email)"
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
                    let alertController = UIAlertController(title: "Success!", message: "Credit card successfully removed.", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil))
                    self.present(alertController, animated: true, completion: nil)
                }// end if
                    
                else {
                    let alertController = UIAlertController(title: "Error", message: "Credit card could not be removed at this time.", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil))
                    self.present(alertController, animated: true, completion: nil)
                }//end else
            }// end dispatch queue sync
            
        }//end of task
        task.resume() // means run task
        getData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creditCardIndex = -1
        if (credList.count == 0){
            return
        }
        getData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getData()
        creditCardIndex = -1
        if (credList.count == 0){
            return
        }
        getData()
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
        stringCredList.removeAll()
        credList = []
        let request = NSMutableURLRequest(url: NSURL(string: "https://mblood2.create.stedwards.edu/walkATX/getCredit.php")! as URL)
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
            self.credList = try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
            DispatchQueue.main.async {
                print(self.credList)
                if (self.credList.count == 0){ return}
                else{
                for index in 0...self.credList.count-1{
                    let mainData = self.credList[index] as? [String:Any]
                    cred = (mainData?["creditCard"] as? String)!
                    stringCredList.append(cred)
                }
                
                print(stringCredList)
 
                self.button = dropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
                self.button.setTitle("Select Credit Card", for: .normal)
                self.button.translatesAutoresizingMaskIntoConstraints = false
                self.view.addSubview(self.button)
                self.button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
                self.button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 298).isActive = true
                self.button.widthAnchor.constraint(equalToConstant: 256).isActive = true
                self.button.heightAnchor.constraint(equalToConstant: 40).isActive = true
                self.button.dropView.dropDownOptions = stringCredList
                }
            }
                
                
            
        }//end of task
        task.resume() // means run task
    }

}
