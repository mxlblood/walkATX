//
//  ViewPetViewController.swift
//  walkATX
//
//  Created by Maximilian Blood on 4/24/18.
//  Copyright © 2018 Maximilian Blood. All rights reserved.
//

import UIKit


var petName : String = ""
var petType : String = ""
var petBreed : String = ""
var age : String = ""
var additional : String = ""

class ViewPetViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    //var ageButton = dropDownBtn()
    //var typeButton = dropDownBtn()
    //var dropView = dropDownView()
    var ageList : [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16+"]
    
    @IBOutlet weak var imgPetPhoto: UIImageView!
    @IBAction func btnAddPet(_ sender: UIButton) {
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
        
    }
    
    @IBOutlet weak var txtPetName: UITextField!
    @IBOutlet weak var txtPetType: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var txtBreed: UITextField!
    @IBOutlet weak var txtAdditional: UITextField!
    @IBAction func btnUpdatePet(_ sender: UIButton) {
        if(txtPetName.text! == "" || txtPetType.text! == "" || txtBreed.text! == "" || txtAdditional.text! == "" || txtAge.text == "")
        {
            let ac = UIAlertController(title: "Empty fields detected", message: "Please enter all information for your pet.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
            
        else{
            let request = NSMutableURLRequest(url: NSURL(string: "https://www.mblood2.create.stedwards.edu/walkATX/updatePet.php")! as URL)
            request.httpMethod = "POST"
            let postString = "a=\(txtPetName.text!)&b=\(txtPetType.text!)&c=\(txtBreed.text!)&d=\(txtAdditional.text!)&e=\(email)&f=\(txtAge.text!)"
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
                        let alertController = UIAlertController(title: "Success!", message: "Pet information updated successfully.", preferredStyle: UIAlertControllerStyle.alert)
                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (alertController) in
                            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "tabVC") as! UITabBarController
                            //self.present(nextViewController, animated: true, completion: nil)
                            self.present(nextViewController, animated: true, completion: nil)
                        })
                        
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                        s_email = email
                        self.saveProfilePicture()
                        self.txtPetName.text = ""
                        self.txtPetType.text = ""
                        self.txtAge.text = ""
                        self.txtBreed.text = ""
                        self.txtAdditional.text = ""
                        self.imgPetPhoto.image = UIImage(named: "noPicture")
                    }// end if for success
                    else{
                        let alertController = UIAlertController(title: "Error", message: "Pet information could not be updated at this time.", preferredStyle: UIAlertControllerStyle.alert)
                        alertController.addAction(UIAlertAction(title:"OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alertController, animated: true, completion:nil)
                    }// end else
                    self.txtPetName.text = ""
                    self.txtPetType.text = ""
                    self.txtAge.text = ""
                    self.txtBreed.text = ""
                    self.txtAdditional.text = ""
                    self.imgPetPhoto.image = UIImage(named: "noPicture")
                }// end dispatch queue sync
                
            }// end of task
            task.resume()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getProfilePicture()
        //getPetData()
        if(petList.count == 0){return}
        else{
            let mainData = petList[0] as? [String:Any]
            petName = (mainData?["petName"] as? String)!
            petType = (mainData?["petType"] as? String)!
            petBreed = (mainData?["petBreed"] as? String)!
            age = (mainData?["age"] as? String)!
            additional = (mainData?["additional"] as? String)!
            email = (mainData?["email"] as? String)!
            
            self.txtPetName.text = petName
            self.txtPetType.text = petType
            self.txtBreed.text = petBreed
            self.txtAge.text = age
            self.txtAdditional.text = additional
        }
        //getPetData()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //need to update page so keyboard dissapears
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
                    petType = (mainData?["petType"] as? String)!
                    petBreed = (mainData?["petBreed"] as? String)!
                    age = (mainData?["age"] as? String)!
                    additional = (mainData?["additional"] as? String)!
                    email = (mainData?["email"] as? String)!
                    
                    self.txtPetName.text = petName
                    self.txtPetType.text = petType
                    self.txtBreed.text = petBreed
                    self.txtAge.text = age
                    self.txtAdditional.text = additional
                }
            }
            
        }//end of task
        task.resume() // means run task
    }
    
    func getProfilePicture()
    {
        let url = NSURL(string: "https://www.mblood2.create.stedwards.edu/walkATX/images/\(email)/user-profile.jpg")
        DispatchQueue.global(qos: .background).async {
            let imageData = NSData(contentsOf: url! as URL)
            if(imageData != nil)
            {
                DispatchQueue.main.async(execute: {
                    self.imgPetPhoto.image = UIImage(data: imageData! as Data)
                })
            }
        }
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
