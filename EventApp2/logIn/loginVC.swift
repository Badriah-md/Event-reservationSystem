//
//  logInVC.swift
//  EventApp2
//
//  Created by Bdoor on 26/07/1440 AH.
//  Copyright © 1440 badriah. All rights reserved.
//

import UIKit



class loginVC: UIViewController,UITextFieldDelegate {
    
    let users = [User]()
    var getTitle2 = String()
    var getLocation2 = String()
    var getDate2 = String()
    
   @IBOutlet weak var usernameLbl: UITextField!
    
    @IBOutlet weak var passwordLbl: UITextField!
    
    
    @IBOutlet weak var Activity: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Activity.isHidden = true
       print(getTitle2,getDate2,getLocation2)
        
       
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func getTapped(_ sender: Any) {
       
        
        if Activity.isAnimating == true{
            Activity.isHidden = true
            Activity.startAnimating()
        }
        else{
            Activity.isHidden = false
            Activity.startAnimating()
        }
        
        let username = usernameLbl.text!
        let password = passwordLbl.text!
        
        let parameters = ["wsUserName":"mobile_apps","wsPassword":"Kku_mobile1","userId":"\(username)","password":"\(password)","domain":"KKU.EDU.SA"]
        
        
        
        let jsonString = "https://itcsvc.kku.edu.sa/KKU_MobileAppWS/v1/auth/checkUserIdAndPassword"
        
        guard let url = URL(string: jsonString) else{return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpbody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else{return}
        request.httpBody = httpbody

        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else{return}
            do{
                
                let json = try JSONDecoder().decode(User.self, from: data) 
               
                print(json)
                if json.result == "true"{
                    
                    
                    
                    DispatchQueue.main.async {
                        //UserDefaults.standard.set(true, forKey: "ISUSERLOGGEDIN")
                        let Dvc4 = self.storyboard!.instantiateViewController(withIdentifier: "arabic_events") as! arabic_events
                        self.navigationController?.pushViewController(Dvc4, animated: true)
                        var one = (json.userInfo?.userName)!
//
                        Dvc4.getName = one
                        Dvc4.getEmail = (json.userInfo?.userEmail)!
                        Dvc4.getMob = (json.userInfo?.userPhoneNumber)!
                        print(Dvc4)
                        self.Activity.isHidden = false
                        
                        
                        
                        
                    }
                    
                    
                }else if json.result == "error"{
                    
                    
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "error", message: "password or user not found", preferredStyle: .alert)
                        let action = UIAlertAction(title: "ok", style: .default, handler: nil)
                        alert.addAction(action)
                        
                        self.present(alert,animated: true,completion: nil)
                        self.Activity.isHidden = true
                    }
                    
                }
            }catch{
                print(error)
            }
            }.resume()
        
    }
    
}

