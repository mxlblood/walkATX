//
//  ScheduleBoardingViewController.swift
//  walkATX
//
//  Created by Maximilian Blood on 4/23/18.
//  Copyright © 2018 Maximilian Blood. All rights reserved.
//

import UIKit

var boardingStartDate : String = ""
var boardingEndDate : String = ""

var bsd = Date()
var bed = Date()

class ScheduleBoardingViewController: UIViewController {

    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBAction func startDateChanged(_ sender: UIDatePicker) {
        bsd = startDatePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        let strDate = dateFormatter.string(from: startDatePicker.date)
        boardingStartDate = strDate
    }
    @IBAction func endDateChanged(_ sender: UIDatePicker) {
        bed = endDatePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        let ndDate = dateFormatter.string(from: endDatePicker.date)
        boardingEndDate = ndDate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date()
        startDatePicker.date = date
        endDatePicker.date = date
        bsd = startDatePicker.date
        bed = endDatePicker.date
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(true)
        let date = Date()
        startDatePicker.date = date
        endDatePicker.date = date
        bsd = startDatePicker.date
        bed = endDatePicker.date
        getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            credList = try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
            DispatchQueue.main.async {
                print(credList)
                if(credList.count == 0) {return}
                else {
                    for index in 0...credList.count-1{
                        let mainData = credList[index] as? [String:Any]
                        cred = (mainData?["creditCard"] as? String)!
                        stringCredList.append(cred)
                    }
                    print(stringCredList)
                }
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
    }

}
