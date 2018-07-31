//
//  ScheduleWalkViewController.swift
//  walkATX
//
//  Created by Maximilian Blood on 4/23/18.
//  Copyright © 2018 Maximilian Blood. All rights reserved.
//

import UIKit

var startWalkTime = Date()
var endWalkTime = Date()
var walkStartDate = Date()
var daySelection : Int = 0
var timeType : Int = 0
var walkType : Int = 0
var lastMinute : Int = 0
var lateWalk : Int = 0

class ScheduleWalkViewController: UIViewController {
    
    @IBOutlet weak var lblGreeting: UILabel!
    @IBOutlet weak var lblSun: UILabel!
    @IBOutlet weak var lblMon: UILabel!
    @IBOutlet weak var lblTues: UILabel!
    @IBOutlet weak var lblWed: UILabel!
    @IBOutlet weak var lblThu: UILabel!
    @IBOutlet weak var lblFri: UILabel!
    @IBOutlet weak var lblSat: UILabel!
    
    @IBOutlet weak var btnSunOutlet: UIButton!
    @IBAction func btnSun(_ sender: UIButton) {
        daySelection = 1
        btnSunOutlet.backgroundColor = #colorLiteral(red: 0.8549019608, green: 0.4274509804, blue: 0.01960784314, alpha: 1)
        btnMonOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btnTuesOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btnWedOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btnThuOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btnFriOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btnSatOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
    }
    
    @IBOutlet weak var btnMonOutlet: UIButton!
    @IBAction func btnMon(_ sender: UIButton) {
        daySelection = 2
        btnSunOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btnMonOutlet.backgroundColor = #colorLiteral(red: 0.8549019608, green: 0.4274509804, blue: 0.01960784314, alpha: 1)
        btnTuesOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btnWedOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btnThuOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btnFriOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btnSatOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
    }
    
    @IBOutlet weak var btnTuesOutlet: UIButton!
    @IBAction func btnTues(_ sender: UIButton) {
        daySelection = 3
        btnSunOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btnMonOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btnTuesOutlet.backgroundColor = #colorLiteral(red: 0.8549019608, green: 0.4274509804, blue: 0.01960784314, alpha: 1)
        btnWedOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btnThuOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btnFriOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btnSatOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
    }
    
    @IBOutlet weak var btnWedOutlet: UIButton!
    @IBAction func btnWed(_ sender: UIButton) {
        daySelection = 4
        btnSunOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btnMonOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btnTuesOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btnWedOutlet.backgroundColor = #colorLiteral(red: 0.8549019608, green: 0.4274509804, blue: 0.01960784314, alpha: 1)
        btnThuOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btnFriOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btnSatOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
    }

    @IBOutlet weak var btnThuOutlet: UIButton!
    @IBAction func btnThu(_ sender: UIButton) {
        daySelection = 5
        btnSunOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btnMonOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btnTuesOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btnWedOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btnThuOutlet.backgroundColor = #colorLiteral(red: 0.8549019608, green: 0.4274509804, blue: 0.01960784314, alpha: 1)
        btnFriOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btnSatOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
    }
    
    @IBOutlet weak var btnFriOutlet: UIButton!
    @IBAction func btnFri(_ sender: UIButton) {
        daySelection = 6
        btnSunOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btnMonOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btnTuesOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btnWedOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btnThuOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btnFriOutlet.backgroundColor = #colorLiteral(red: 0.8549019608, green: 0.4274509804, blue: 0.01960784314, alpha: 1)
        btnSatOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
    }
    
    @IBOutlet weak var btnSatOutlet: UIButton!
    @IBAction func btnSat(_ sender: UIButton) {
        daySelection = 7
        btnSunOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btnMonOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btnTuesOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btnWedOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btnThuOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btnFriOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btnSatOutlet.backgroundColor = #colorLiteral(red: 0.8549019608, green: 0.4274509804, blue: 0.01960784314, alpha: 1)
    }
    
    @IBOutlet weak var btnOneTimeOutlet: UIButton!
    @IBAction func btnOneTime(_ sender: UIButton) {
        timeType = 1
        btnOneTimeOutlet.backgroundColor = #colorLiteral(red: 0.8549019608, green: 0.4274509804, blue: 0.01960784314, alpha: 1)
        btnWeeklyOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
    }
    
    @IBOutlet weak var btnWeeklyOutlet: UIButton!
    @IBAction func btnWeekly(_ sender: UIButton) {
        timeType = 2
        btnOneTimeOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btnWeeklyOutlet.backgroundColor = #colorLiteral(red: 0.8549019608, green: 0.4274509804, blue: 0.01960784314, alpha: 1)
    }
    
    @IBOutlet weak var startTimePicker: UIDatePicker!
    @IBAction func startTimeChanged(_ sender: UIDatePicker) {
        startWalkTime = startTimePicker.date
    }
    
    @IBOutlet weak var endTimePicker: UIDatePicker!
    @IBAction func endTimeChanged(_ sender: UIDatePicker) {
        endWalkTime = endTimePicker.date
    }
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        walkStartDate = datePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateResult = dateFormatter.string(from: walkStartDate)
        let day = getDayOfWeek(dateResult)
        if (day == 2){
            daySelection = 2
            btnSunOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
            btnMonOutlet.backgroundColor = #colorLiteral(red: 0.8549019608, green: 0.4274509804, blue: 0.01960784314, alpha: 1)
            btnTuesOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
            btnWedOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
            btnThuOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
            btnFriOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
            btnSatOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        }
        else if (day == 3){
            daySelection = 3
            btnSunOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
            btnMonOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
            btnTuesOutlet.backgroundColor = #colorLiteral(red: 0.8549019608, green: 0.4274509804, blue: 0.01960784314, alpha: 1)
            btnWedOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
            btnThuOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
            btnFriOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
            btnSatOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        }
        else if (day == 4){
            daySelection = 4
            btnSunOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
            btnMonOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
            btnTuesOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
            btnWedOutlet.backgroundColor = #colorLiteral(red: 0.8549019608, green: 0.4274509804, blue: 0.01960784314, alpha: 1)
            btnThuOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
            btnFriOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
            btnSatOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        }
        else if (day == 5){
            daySelection = 5
            btnSunOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
            btnMonOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
            btnTuesOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
            btnWedOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
            btnThuOutlet.backgroundColor = #colorLiteral(red: 0.8549019608, green: 0.4274509804, blue: 0.01960784314, alpha: 1)
            btnFriOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
            btnSatOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        }
        else if (day == 6){
            daySelection = 6
            btnSunOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
            btnMonOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
            btnTuesOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
            btnWedOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
            btnThuOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
            btnFriOutlet.backgroundColor = #colorLiteral(red: 0.8549019608, green: 0.4274509804, blue: 0.01960784314, alpha: 1)
            btnSatOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        }
        else if (day == 7){
            daySelection = 7
            btnSunOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
            btnMonOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
            btnTuesOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
            btnWedOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
            btnThuOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
            btnFriOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
            btnSatOutlet.backgroundColor = #colorLiteral(red: 0.8549019608, green: 0.4274509804, blue: 0.01960784314, alpha: 1)
        }
        else if (day == 1){
            daySelection = 1
            btnSunOutlet.backgroundColor = #colorLiteral(red: 0.8549019608, green: 0.4274509804, blue: 0.01960784314, alpha: 1)
            btnMonOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
            btnTuesOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
            btnWedOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
            btnThuOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
            btnFriOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
            btnSatOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        }
    }
    
    @IBOutlet weak var btnLetOutlet: UIButton!
    @IBAction func btnLetOut(_ sender: UIButton) {
        walkType = 1
        btnLetOutlet.backgroundColor = #colorLiteral(red: 0.8549019608, green: 0.4274509804, blue: 0.01960784314, alpha: 1)
        btn30minOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btnHrOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btnHikeOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
    }
    
    @IBOutlet weak var btn30minOutlet: UIButton!
    @IBAction func btn30min(_ sender: UIButton) {
        walkType = 2
        btnLetOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btn30minOutlet.backgroundColor = #colorLiteral(red: 0.8549019608, green: 0.4274509804, blue: 0.01960784314, alpha: 1)
        btnHrOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btnHikeOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
    }
    
    @IBOutlet weak var btnHrOutlet: UIButton!
    @IBAction func btnHr(_ sender: UIButton) {
        walkType = 3
        btnLetOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btn30minOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btnHrOutlet.backgroundColor = #colorLiteral(red: 0.8549019608, green: 0.4274509804, blue: 0.01960784314, alpha: 1)
        btnHikeOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
    }
    
    @IBOutlet weak var btnHikeOutlet: UIButton!
    @IBAction func btnHike(_ sender: UIButton) {
        walkType = 4
        btnLetOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btn30minOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btnHrOutlet.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        btnHikeOutlet.backgroundColor = #colorLiteral(red: 0.8549019608, green: 0.4274509804, blue: 0.01960784314, alpha: 1)
    }
    
    @IBAction func btnContinue(_ sender: UIButton) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour], from: startWalkTime)
        let hour = components.hour!
        if ( daySelection == 0 || timeType == 0 || walkType == 0 ){
            let alertController = UIAlertController(title: "Empty Fields Detected", message: "Please make sure all options are selected.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil))
            self.present(alertController, animated: true, completion: nil)
        }
        else if (hour > 17) {
            lateWalk = 1
            let alertController = UIAlertController(title: "Surcharges are applied to walks scheduled after 5pm and before 9am.", message: "Press OK to continue or cancel to adjust walk time", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (alertController) in
                let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "walkCheckoutVC") as! WalkCheckoutViewController
                self.present(nextViewController, animated: true, completion: nil)
            })
            alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler:nil))
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else if (hour < 9) {
            lateWalk = 1
            let alertController = UIAlertController(title: "Walk Time Selected Before 9am", message: "Surcharges are applied to walks scheduled after 5pm and before 9am.", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (alertController) in
                let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "walkCheckoutVC") as! WalkCheckoutViewController
                self.present(nextViewController, animated: true, completion: nil)
            })
            alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler:nil))
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "walkCheckoutVC") as! WalkCheckoutViewController
            self.present(nextViewController, animated: true, completion: nil)
        }
    }
    
    func getDayOfWeek(_ today:String) -> Int? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let todayDate = formatter.date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        return weekDay
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblGreeting.text = "When does \(petName) need a walk?"
        let date = Date()
        getData()
        startTimePicker.minuteInterval = 30
        endTimePicker.minuteInterval = 30
        startTimePicker.date = date
        endTimePicker.date = date
        datePicker.date = date
        //startTimePicker.minuteInterval = 120
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateResult = dateFormatter.string(from: date)
        let day = getDayOfWeek(dateResult)
        if (day == 2){
            lblMon.text = "Today"
            lblTues.text = ""
            lblWed.text = ""
            lblThu.text = ""
            lblFri.text = ""
            lblSat.text = ""
            lblSun.text = ""
        }
        else if (day == 3){
            lblMon.text = ""
            lblTues.text = "Today"
            lblWed.text = ""
            lblThu.text = ""
            lblFri.text = ""
            lblSat.text = ""
            lblSun.text = ""
        }
        else if (day == 4){
            lblMon.text = ""
            lblTues.text = ""
            lblWed.text = "Today"
            lblThu.text = ""
            lblFri.text = ""
            lblSat.text = ""
            lblSun.text = ""
        }
        else if (day == 5){
            lblMon.text = ""
            lblTues.text = ""
            lblWed.text = ""
            lblThu.text = "Today"
            lblFri.text = ""
            lblSat.text = ""
            lblSun.text = ""
        }
        else if (day == 6){
            lblMon.text = ""
            lblTues.text = ""
            lblWed.text = ""
            lblThu.text = ""
            lblFri.text = "Today"
            lblSat.text = ""
            lblSun.text = ""
        }
        else if (day == 7){
            lblMon.text = ""
            lblTues.text = ""
            lblWed.text = ""
            lblThu.text = ""
            lblFri.text = ""
            lblSat.text = "Today"
            lblSun.text = ""
        }
        else if (day == 1){
            lblMon.text = ""
            lblTues.text = ""
            lblWed.text = ""
            lblThu.text = ""
            lblFri.text = ""
            lblSat.text = ""
            lblSun.text = "Today"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        lblGreeting.text = "When does \(petName) need a walk?"
        let date = Date()
        getData()
        startTimePicker.minuteInterval = 30
        endTimePicker.minuteInterval = 30
        startTimePicker.date = date
        endTimePicker.date = date
        datePicker.date = date
        //startTimePicker.minuteInterval = 120
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateResult = dateFormatter.string(from: date)
        let day = getDayOfWeek(dateResult)
        if (day == 2){
            lblMon.text = "Today"
            lblTues.text = ""
            lblWed.text = ""
            lblThu.text = ""
            lblFri.text = ""
            lblSat.text = ""
            lblSun.text = ""
        }
        else if (day == 3){
            lblMon.text = ""
            lblTues.text = "Today"
            lblWed.text = ""
            lblThu.text = ""
            lblFri.text = ""
            lblSat.text = ""
            lblSun.text = ""
        }
        else if (day == 4){
            lblMon.text = ""
            lblTues.text = ""
            lblWed.text = "Today"
            lblThu.text = ""
            lblFri.text = ""
            lblSat.text = ""
            lblSun.text = ""
        }
        else if (day == 5){
            lblMon.text = ""
            lblTues.text = ""
            lblWed.text = ""
            lblThu.text = "Today"
            lblFri.text = ""
            lblSat.text = ""
            lblSun.text = ""
        }
        else if (day == 6){
            lblMon.text = ""
            lblTues.text = ""
            lblWed.text = ""
            lblThu.text = ""
            lblFri.text = "Today"
            lblSat.text = ""
            lblSun.text = ""
        }
        else if (day == 7){
            lblMon.text = ""
            lblTues.text = ""
            lblWed.text = ""
            lblThu.text = ""
            lblFri.text = ""
            lblSat.text = "Today"
            lblSun.text = ""
        }
        else if (day == 1){
            lblMon.text = ""
            lblTues.text = ""
            lblWed.text = ""
            lblThu.text = ""
            lblFri.text = ""
            lblSat.text = ""
            lblSun.text = "Today"
        }
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
                if (credList.count == 0) {return}
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
                 self.button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 496).isActive = true
                 //button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
                 self.button.widthAnchor.constraint(equalToConstant: 343).isActive = true
                 self.button.heightAnchor.constraint(equalToConstant: 40).isActive = true
                 self.button.dropView.dropDownOptions = stringCredList
                 */
            }
        }//end of task
        task.resume() // means run task
    }

}

















