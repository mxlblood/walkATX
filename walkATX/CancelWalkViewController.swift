//
//  CancelWalkViewController.swift
//  walkATX
//
//  Created by Maximilian Blood on 5/3/18.
//  Copyright © 2018 Maximilian Blood. All rights reserved.
//

import UIKit

var walkDate : String = ""
var walkStartTime : String = ""
var walkEndTime : String = ""
var walkLength : String = ""
var stringWalkType : String = ""

class CancelWalkViewController: UIViewController {
    var walkID : Int? = 0
    //var walkString = ""
    //var walkList : NSArray = []
    
    @IBOutlet weak var lblWalkDate: UILabel!
    @IBOutlet weak var lblWalkTime: UILabel!
    @IBOutlet weak var lblWalkLength: UILabel!
    @IBOutlet weak var lblWalkType: UILabel!
    @IBAction func btnCancelWalk(_ sender: UIButton) {
        let request = NSMutableURLRequest(url: NSURL(string: "https://mblood2.create.stedwards.edu/walkATX/removeWalk.php")! as URL)
        request.httpMethod = "POST"
        let postString = "a=\(walkID!)"
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
                    let alertController = UIAlertController(title: "Success!", message: "Walk successfully removed.", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil))
                    self.present(alertController, animated: true, completion: nil)
                    self.getWalkDates()
                    scheduleIndex = 0
                    self.lblWalkDate.text = ""
                    self.lblWalkTime.text = ""
                    self.lblWalkType.text = ""
                    self.lblWalkLength.text = ""
                    //getData()
                }// end if
                    
                else {
                    let alertController = UIAlertController(title: "Error", message: "Walk could not be removed at this time.", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil))
                    self.present(alertController, animated: true, completion: nil)
                }//end else
            }// end dispatch queue sync
            
        }//end of task
        task.resume() // means run task
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let mainData = walkDateList[scheduleIndex] as? [String:Any]
        let walkString = mainData?["walkID"] as? String
        walkID = Int(walkString!)
        print(walkID!)
        //getData()
        
        let data = walkList[0] as? [String:Any]
        walkStartTime = (data?["walkStartTime"] as? String)!
        walkEndTime = (data?["walkEndTime"] as? String)!
        walkDate = (data?["startDate"] as? String)!
        stringWalkType = (data?["timeType"] as? String)!
        walkLength = (data?["walkType"] as? String)!
        
        self.lblWalkDate.text = " Date: \(walkDate) "
        self.lblWalkTime.text = " Time: \(walkStartTime) - \(walkEndTime)"
        if (stringWalkType == "1"){
            self.lblWalkType.text = " Type: One Time"
        }
        else if (stringWalkType == "2"){
            self.lblWalkType.text = " Type: Weekly"
        }
        
        if (walkLength == "1"){
            self.lblWalkLength.text = " Length of Walk: Let Out"
        }
        else if (walkLength == "2"){
            self.lblWalkLength.text = " Length of Walk: 30 minutes"
        }
        else if (walkLength == "3"){
            self.lblWalkLength.text = " Length of Walk: 1 hour"
        }
        else if (walkLength == "4"){
            self.lblWalkLength.text = " Length of Walk: 2+ hour hike"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getWalkDates() {
        walkDateList = []
        let request = NSMutableURLRequest(url: NSURL(string: "https://mblood2.create.stedwards.edu/walkATX/getWalkDates.php")! as URL)
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
            walkDateList = try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
            DispatchQueue.main.async {
                print(walkDateList)
            }
        }//end of task
        task.resume() // means run task
    }
    


}
