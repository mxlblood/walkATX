//
//  ViewScheduleViewController.swift
//  walkATX
//
//  Created by Maximilian Blood on 5/3/18.
//  Copyright © 2018 Maximilian Blood. All rights reserved.
//

import UIKit

//var finalList : NSArray = []
var scheduleIndex = 0
var walkList : NSArray = []
var walkID : Int? = 0

class ViewScheduleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    //var overnightDateList : NSArray = []
    //var boardingDateList : NSArray = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return walkDateList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "proCell", for: indexPath)
        let mainData = walkDateList[indexPath.row] as? [String:Any]
        cell.textLabel?.text = mainData?["startDate"] as? String
        //cell.detailTextLabel?.text = mainData["password"] as? String
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
        var indexPath = tableView.indexPathForSelectedRow!
        scheduleIndex = indexPath.row
    }
    
    /*
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == UITableViewCellEditingStyle.delete {
         walkDateList.remove(at: indexPath.row)
         }
         //need to update user defaults and refresh table after deleted
         tblSchedule.reloadData()
         
         }
    func getOvernightDates() {
        stringCredList.removeAll()
        let request = NSMutableURLRequest(url: NSURL(string: "https://mblood2.create.stedwards.edu/walkATX/getOvernightDates.php")! as URL)
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
            self.overnightDateList = try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
            DispatchQueue.main.async {
                finalList.addingObjects(from: self.overnightDateList as! [Any])
            }
        }//end of task
        print(overnightDateList)
        task.resume() // means run task
        tblSchedule.reloadData()
    }
    
    func getBoardingDates() {
        stringCredList.removeAll()
        let request = NSMutableURLRequest(url: NSURL(string: "https://mblood2.create.stedwards.edu/walkATX/getBoardingDates.php")! as URL)
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
            self.boardingDateList = try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
             DispatchQueue.main.async {
                finalList.addingObjects(from: self.boardingDateList as! [Any])
            }
        }//end of task
        print(boardingDateList)
        task.resume() // means run task
        
        tblSchedule.reloadData()
    }
 */
    
    @IBOutlet weak var tblSchedule: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        
        //finalList = []
        //getWalkDates()
        tblSchedule.reloadData()
        //getOvernightDates()
        //getBoardingDates()
        //walkDateList = ["1","2", "3"]
        //overnightDateList = ["1","2", "3"]
        //boardingDateList = ["1","2", "3"]
        //finalList.addingObjects(from: walkDateList as! [Any])
    }
    
    //preparing for a view to load
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getData()
        
        //finalList = []
        //getWalkDates()
        tblSchedule.reloadData()
        //getOvernightDates()
        //getBoardingDates()
        //tblTable.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData() {
        let request = NSMutableURLRequest(url: NSURL(string: "https://mblood2.create.stedwards.edu/walkATX/getWalkInfo.php")! as URL)
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
            walkList = try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
        }//end of task
        task.resume() // means run task
    }
    

}
