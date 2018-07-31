//
//  FirstViewController.swift
//  walkATX
//
//  Created by Maximilian Blood on 4/16/18.
//  Copyright © 2018 Maximilian Blood. All rights reserved.
//

import UIKit

var walkDateList : NSArray = []
var petList : NSArray = []
var dataList : NSArray = []

class HomeViewController: UIViewController {

    @IBAction func btnSignOut(_ sender: UIButton) {
        email = ""
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "welcomeVC") as! WelcomeViewController
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.setNavigationBarHidden(true, animated: true)
        getWalkDates()
        getAccountData()
        print(walkID!)
        getPetData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getWalkDates()
        getAccountData()
        print(walkID!)
        getPetData()
    }
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getWalkDates() {
        //walkDateList = []
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
                if (walkDateList.count == 0) {return}
                else{
                    let mainData = walkDateList[scheduleIndex] as? [String:Any]
                    let walkString = mainData?["walkID"] as? String
                    walkID = Int(walkString!)
                }
            }
        }//end of task
        task.resume() // means run task
        
    }
    
    func getAccountData() {
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
            }
            
        }//end of task
        task.resume() // means run task
    }

    
    func getPetData()
    {
        //petList=[]
        let request = NSMutableURLRequest(url: NSURL(string: "https://mblood2.create.stedwards.edu/walkATX/getPet.php")! as URL)
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
            petList = try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
            DispatchQueue.main.async {
                print(petList)
                if(petList.count == 0) {return}
                else{
                    let mainData = petList[0] as? [String:Any]
                    petName = (mainData?["petName"] as? String)!
                }
            }
            
        }//end of task
        task.resume() // means run task
    }

}

