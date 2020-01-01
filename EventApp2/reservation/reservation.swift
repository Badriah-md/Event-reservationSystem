//
//  reservation.swift
//  EventApp2
//
//  Created by Bdoor on 26/07/1440 AH.
//  Copyright © 1440 badriah. All rights reserved.
//

import UIKit
import FirebaseDatabase

protocol finalDelegate{
    func finishPassing(string:String)
}

class reservation: UIViewController {
    //let json = try JSONDecoder().decode(User.self, from: data)
    var getTitle3 = String()
    var getLocation3 = String()
    var getDate3 = String()
    var getName3 = String()
    var getEmail3 = String()
    var getMobNo3 = String()
    
    var delegate:finalDelegate?
    var titleLbl = ""
    @IBOutlet weak var userNameLbl: UILabel!
    
    @IBOutlet weak var mobileNo: UILabel!
    
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
     @IBOutlet weak var eventNmae: UILabel!
    @IBAction func backToevent(_ sender: Any) {
        
        delegate?.finishPassing(string: "\(getName3)")
//        let Dvc = storyboard!.instantiateViewController(withIdentifier: "arabic_events") as! arabic_events
//        self.navigationController?.pushViewController(Dvc, animated: true)
//
//        Dvc.getName = getName3
//        Dvc.getEmail = getEmail3
//        Dvc.getMob = getMobNo3
//        print(getEmail3)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       print(getTitle3,getDate3,getLocation3)
        eventNmae.text! = getTitle3
        eventDate.text! = getDate3
        eventLocation.text! = getLocation3
        userNameLbl.text! = getName3
        email.text! = getEmail3
        mobileNo.text = getMobNo3

        // Do any additional setup after loading the view.
    }
    
    @IBAction func reserTapped(_ sender: Any) {
        let smtpSession = MCOSMTPSession()
        smtpSession.hostname = "smtp.gmail.com"
        smtpSession.username = "kku.events@gmail.com"
        smtpSession.password = "123KKU_events"
        smtpSession.port = 465
        smtpSession.authType = MCOAuthType.saslPlain
        smtpSession.connectionType = MCOConnectionType.TLS
        smtpSession.connectionLogger = {(connectionID, type, data) in
            if data != nil {
                if let string = NSString(data: data!, encoding: String.Encoding.utf8.rawValue){
                    NSLog("Connectionlogger: \(string)")
                }
            }
        }
        let builder = MCOMessageBuilder()
        builder.header.to = [MCOAddress(displayName: "KKU", mailbox: "\(getEmail3)")]
        builder.header.from = MCOAddress(displayName: "KKU_EVENT", mailbox: "bdoor92@gmail.com")
        builder.header.subject = "Test Email"
        builder.htmlBody="<p align=right> عزيزي \(getName3)لقد تم حجز مقعد في فعالية    \(getTitle3)في يوم وتاريخ <br> \(getDate3)المنعقده باذن الله في <br> \(getLocation3) </p> <img src=kku-logo.jpg alt=Smiley face height=42 width=42>"
        
        
        let rfc822Data = builder.data()
        let sendOperation = smtpSession.sendOperation(with: rfc822Data)
        sendOperation?.start { (error) -> Void in
            if (error != nil) {
                NSLog("Error sending email: \(String(describing: error))")
                
                
            } else {
                NSLog("Successfully sent email!")
                let alert = UIAlertController(title: "تم الحجز", message: "تم ارسال تذكرة الحجز الى الايميل الجامعي", preferredStyle: .alert)
                let action = UIAlertAction(title: "ok", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert,animated: true,completion: nil)
                
                let ref = Database.database().reference()
                
                ref.childByAutoId().setValue(["name":"\(self.getName3)","email":"\(self.getEmail3)","mobile":"\(self.getMobNo3)","eventName":"\(self.getTitle3)","eventDate":"\(self.getDate3)","eventLocation":"\(self.getLocation3)"])
                
            }
        }

         
    }
    
    
   
    

}
