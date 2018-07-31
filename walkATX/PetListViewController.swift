//
//  PetListViewController.swift
//  walkATX
//
//  Created by Maximilian Blood on 4/24/18.
//  Copyright © 2018 Maximilian Blood. All rights reserved.
//

import UIKit

class PetListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var petList : NSArray = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "proCell", for: indexPath)
        let mainData = petList[indexPath.row] as? [String:Any]
        cell.textLabel?.text = mainData?["username"] as? String
        return cell
    }
    
    func getPets() {
        let url = NSURL(string: "https://mblood2.create.stedwards.edu/iOSapp/getPets.php")
        let data = NSData(contentsOf: url! as URL)
        petList = try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
        print(petList)
        tblPets.reloadData()
    }
    

    @IBOutlet weak var tblPets: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getPets()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getPets()
    }
    


}
