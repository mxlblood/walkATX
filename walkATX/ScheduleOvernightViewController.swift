//
//  SecondViewController.swift
//  walkATX
//
//  Created by Maximilian Blood on 4/16/18.
//  Copyright © 2018 Maximilian Blood. All rights reserved.
//

import UIKit

var overnightStartDate : String = ""
var overnightEndDate : String = ""

var overnightEnd = Date()
var overnightStart = Date()

var credList = NSArray()

class ScheduleOvernightViewController: UIViewController {

    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBAction func startDateChanged(_ sender: UIDatePicker) {
        overnightStart = startDatePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        let strDate = dateFormatter.string(from: startDatePicker.date)
        overnightStartDate = strDate
    }
    @IBAction func endDateChanged(_ sender: UIDatePicker) {
        overnightEnd = endDatePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        let ndDate = dateFormatter.string(from: endDatePicker.date)
        overnightEndDate = ndDate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date()
        startDatePicker.date = date
        endDatePicker.date = date
        overnightStart = startDatePicker.date
        overnightEnd = endDatePicker.date
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let date = Date()
        startDatePicker.date = date
        endDatePicker.date = date
        overnightStart = startDatePicker.date
        overnightEnd = endDatePicker.date
        getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData() {
        credList = []
        stringCredList.removeAll()
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
            credList = try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
            DispatchQueue.main.async {
                print(credList)
                if(credList.count == 0) {return}
                else{
                    for index in 0...credList.count-1{
                        let mainData = credList[index] as? [String:Any]
                        cred = (mainData?["creditCard"] as? String)!
                        stringCredList.append(cred)
                    }
                }
                //print(stringCredList)
                /*
                 self.button = dropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
                 self.button.setTitle("Select Credit Card", for: .normal)
                 self.button.translatesAutoresizingMaskIntoConstraints = false
                 self.view.addSubview(self.button)
                 self.button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
                 self.button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 466).isActive = true
                 self.button.widthAnchor.constraint(equalToConstant: 343).isActive = true
                 self.button.heightAnchor.constraint(equalToConstant: 40).isActive = true
                 self.button.dropView.dropDownOptions = stringCredList
                 */
            }
            
        }//end of task
        task.resume() // means run task
        DispatchQueue.main.async{
            print(stringCredList)
        }
    }


}

