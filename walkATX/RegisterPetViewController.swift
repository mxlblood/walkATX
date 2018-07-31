//
//  RegisterPetViewController.swift
//  walkATX
//
//  Created by Maximilian Blood on 4/23/18.
//  Copyright © 2018 Maximilian Blood. All rights reserved.
//

import UIKit

var creditCardIndex = -1
var s_email = ""
var s_id = ""
var u_id = 1


class RegisterPetViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    var ageButton = dropDownBtn()
    var typeButton = dropDownBtn()
    var dropView = dropDownView()
    var ageList : [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16+"]
    
    @IBOutlet weak var imgPetPhoto: UIImageView!
    @IBOutlet weak var txtPetname: UITextField!
    @IBOutlet weak var txtType: UITextField!
    
    @IBOutlet weak var txtBreed: UITextField!
    @IBOutlet weak var txtAdditional: UITextView!
    @IBAction func btnAddPet(_ sender: UIButton) {
        if(imgPetPhoto.image == #imageLiteral(resourceName: "petDefault")) {
            let ac = UIAlertController(title: "Please add a photo of your pet to continue", message: "To add a photo of your pet, click the orange plus button.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
        else if(txtPetname.text! == "" || txtType.text! == "" || txtBreed.text! == "" || txtAdditional.text! == "" || creditCardIndex == -1)
        {
            let ac = UIAlertController(title: "Empty fields detected", message: "Please enter all information for your pet.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
            
        else{
            let request = NSMutableURLRequest(url: NSURL(string: "https://www.mblood2.create.stedwards.edu/walkATX/addPet.php")! as URL)
            request.httpMethod = "POST"
            let age = ageList[creditCardIndex]
            let postString = "a=\(txtPetname.text!)&b=\(txtType.text!)&c=\(txtBreed.text!)&d=\(txtAdditional.text!)&e=\(email)&f=\(age)"
            request.httpBody = postString.data(using: String.Encoding.utf8)
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
                if error != nil {
                    print("error =\(error!)")
                    return
                }
                print("response =\(response!)")
                let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("responseString = \(responseString!)")
                
                DispatchQueue.main.async() {
                    let responseString = responseString!.trimmingCharacters(in: .whitespaces)
                    if (responseString == "Success")
                    {
                        s_email = email
                        petName = self.txtPetname.text!
                        let alertController = UIAlertController(title: "Success!", message: "Pet added to account successfully.", preferredStyle: UIAlertControllerStyle.alert)
                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (alertController) in
                            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "tabVC") as! UITabBarController
                            //self.present(nextViewController, animated: true, completion: nil)
                            self.present(nextViewController, animated: true, completion: nil)
                        })
                        
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                        
                        s_email = email
                        
                        self.saveProfilePicture()
                    }// end if for success
                    else{
                        let alertController = UIAlertController(title: "Access Denied", message: "Incorrect username or password.", preferredStyle: UIAlertControllerStyle.alert)
                        alertController.addAction(UIAlertAction(title:"OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alertController, animated: true, completion:nil)
                    }// end else
                    self.txtPetname.text = ""
                    self.txtType.text = ""
                    self.txtBreed.text = ""
                    self.txtAdditional.text = ""
                    self.imgPetPhoto.image = UIImage(named: "noPicture")
                }// end dispatch queue sync
                
            }// end of task
            task.resume()
            
        }
       
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
            }
        }//end of task
        task.resume() // means run task
        
    }
    
    
    @IBAction func btnAddPhoto(_ sender: UIButton) {
        //call camera app to pick image ('take pic') and bring it back
        let imagePicker = UIImagePickerController()
        //self means the view controller i am in
        imagePicker.delegate  = self
        
        //checking if there is a camera in device
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            //source type of imagePicker is .camera
            imagePicker.sourceType = .camera
            
            //already has a camera, checks
            if UIImagePickerController.isCameraDeviceAvailable(.front) {
                imagePicker.cameraDevice = .front
            }
            else {
                imagePicker.cameraDevice = .rear
            }
        }
            //if camera does not exist, load photo album
        else {
            //source type of imagePicker is .photoLibrary
            imagePicker.sourceType = .photoLibrary
        }
        //show me the camera or photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    //image is finished selecting
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //info is dictionary
        //casting to UIImage
        imgPetPhoto.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        //self here is camera or photo album
        self.dismiss(animated: true, completion: nil)
        self.saveProfilePicture()
        
        //permissions to use camera and library
        //how can i program post button?
        // contact facebook API iOS11
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWalkDates()
        
        imgPetPhoto.image = #imageLiteral(resourceName: "petDefault")

        ageButton = dropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        ageButton.setTitle("Age", for: .normal)
        ageButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(ageButton)
        ageButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 62).isActive = true
        ageButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 335).isActive = true
        ageButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        ageButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        ageButton.dropView.dropDownOptions = ageList
        
        /*
        typeButton = dropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        typeButton.setTitle("Select Pet's Age", for: .normal)
        typeButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(ageButton)
        typeButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 62).isActive = true
        typeButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 297).isActive = true
        typeButton.widthAnchor.constraint(equalToConstant: 250).isActive = true
        typeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        typeButton.dropView.dropDownOptions = ["Dog", "Cat", "Other"]
        */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //need to update page so keyboard dissapears
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func saveProfilePicture()
    {
        let myUrl = URL(string: "https://www.mblood2.create.stedwards.edu/walkATX/uploadImage.php");
        
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "POST";
        
        let param = [
            "s_email" : email
        ]
        
        let boundary = generateBoundaryString()
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let imageData = UIImageJPEGRepresentation(imgPetPhoto.image!, 1)
        
        if(imageData==nil)  { return; }
        
        request.httpBody = createBodyWithParameters(param, filePathKey: "file", imageDataKey: imageData!, boundary: boundary)
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            DispatchQueue.main.async
                {
                    //  MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
            }
            
            if error != nil {
                // Display an alert message
                return
            }
            
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                DispatchQueue.main.async
                    {
                        
                        if let parseJSON = json {
                            // let userId = parseJSON["userId"] as? String
                            
                            // Display an alert message
                            let userMessage = parseJSON["message"] as? String
                            self.displayAlertMessage(userMessage!)
                        } else {
                            // Display an alert message
                            let userMessage = "Could not upload image at this time"
                            self.displayAlertMessage(userMessage)
                        }
                }
            } catch
            {
                print(error)
            }
            
        }
        
        task.resume()
    }
    
    func generateBoundaryString() -> String {
        // Create and return a unique string.
        return "Boundary-\(UUID().uuidString)"
    }
    
    func createBodyWithParameters(_ parameters: [String: String]?, filePathKey: String?, imageDataKey: Data, boundary: String) -> Data {
        var body = Data();
        if parameters != nil {
            for (key, value) in parameters! {
                body.append(Data("--\(boundary)\r\n".utf8))
                body.append(Data("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".utf8))
                body.append(Data("\(value)\r\n".utf8))
                body.append(Data("--\(boundary)\r\n".utf8))
                
            }
        }
        
        let filename = "user-profile.jpg"
        
        let mimetype = "image/jpg"
        body.append(Data("--\(boundary)\r\n".utf8))
        body.append(Data("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n".utf8))
        body.append(Data("Content-Type: \(mimetype)\r\n\r\n".utf8))
        body.append(imageDataKey)
        body.append(Data("\r\n".utf8))
        
        body.append(Data("--\(boundary)\r\n".utf8))
        
        return body as Data
    }
    
    func displayAlertMessage(_ userMessage:String)
    {
        let myAlert = UIAlertController(title: "Alert", message:userMessage, preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil)
        
        myAlert.addAction(okAction);
        
        self.present(myAlert, animated: true, completion: nil)
        
    }
    
}


extension NSMutableData {
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}


protocol dropDownProtocol {
    func dropDownPressed(string : String)
}

class dropDownBtn: UIButton, dropDownProtocol {
    func dropDownPressed(string: String) {
        self.setTitle(string, for: .normal)
        self.dismissDropDown()
    }
    
    var dropView = dropDownView()
    
    var height = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        //print("hereFrame")
        super.init(frame: frame)
        
        self.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        self.setTitleColor(UIColor.white, for: .normal)
        //print("hereFrame1")
        dropView = dropDownView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        dropView.delegate = self
        dropView.translatesAutoresizingMaskIntoConstraints = false
        //print("hereFrame2")
        self.superview?.addSubview(dropView)
        self.superview?.bringSubview(toFront: dropView)
        //print("hereFrame3")
    }
    
    override func didMoveToSuperview() {
        //print("DIDhere")
        self.superview?.addSubview(dropView)
        //print("DIDhere1")
        self.superview?.bringSubview(toFront: dropView)
        //print("DIDhere2")
        dropView.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        //print("DIDhere3")
        dropView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        //print("DIDhere4")
        dropView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        //print("DIDhere5")
        height = dropView.heightAnchor.constraint(equalToConstant: 0)
    }
    
    var isOpen = false
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isOpen == false {
            isOpen = true
            NSLayoutConstraint.deactivate([self.height])
            
            if self.dropView.tableView.contentSize.height > 100 {
                self.height.constant = 100
            } else {
                self.height.constant = self.dropView.tableView.contentSize.height
            }
            
            NSLayoutConstraint.activate([self.height])
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.dropView.layoutIfNeeded()
                self.dropView.center.y += self.dropView.frame.height / 2
            }, completion: nil)
            
        } else {
            isOpen = false
            NSLayoutConstraint.deactivate([self.height])
            self.height.constant = 0
            NSLayoutConstraint.activate([self.height])
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.dropView.center.y -= self.dropView.frame.height / 2
                self.dropView.layoutIfNeeded()
            }, completion: nil)
            
        }
    }
    
    func dismissDropDown() {
        isOpen = false
        NSLayoutConstraint.deactivate([self.height])
        self.height.constant = 0
        NSLayoutConstraint.activate([self.height])
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.dropView.center.y -= self.dropView.frame.height / 2
            self.dropView.layoutIfNeeded()
        }, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class dropDownView: UIView, UITableViewDelegate, UITableViewDataSource  {
    
    var dropDownOptions = [String]()
    
    var tableView = UITableView()
    
    var delegate : dropDownProtocol!
    
    override init(frame: CGRect) {
        //print("drowDownVIew")
        super.init(frame: frame)
        
        tableView.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        self.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        
        //print("drowDownVIew2")
        tableView.delegate = self
        tableView.dataSource = self
        //print("drowDownVIew3")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        //print("drowDownVIew4")
        self.addSubview(tableView)
        //print("drowDownVIew5")
        tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        //print("drowDownVIew6")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dropDownOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = dropDownOptions[indexPath.row]
        cell.backgroundColor = #colorLiteral(red: 0.9894769788, green: 0.4947487116, blue: 0.01249361224, alpha: 1)
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate.dropDownPressed(string: dropDownOptions[indexPath.row])
        self.tableView.deselectRow(at: indexPath, animated: true)
        creditCardIndex = indexPath.row
    }
    
}
