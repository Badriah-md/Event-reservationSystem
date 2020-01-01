//
//  DetailViewController.swift
//  DecodableWithTableview
//
//  Created by Bdoor on 20/07/1440 AH.
//  Copyright © 1440 X901. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    //to display the details of events
    //variables to handle the information from tableview
    var getTitle = String()
    var getbody = String()
    var getDate = String()
    var getLocation = String()
    var getImage : UIImage!
    var getName2=String()
    var getEmail2=String()
    var getMob2=String()
    var name = ""
    //the UI elements
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var bodyLbl: UITextView!
    @IBOutlet weak var location: UILabel!
    //liked to reservation view controller
    @IBAction func reservationTapped(_ sender: Any) {
        let Dvc2 = storyboard!.instantiateViewController(withIdentifier: "reservation") as! reservation
        self.navigationController?.pushViewController(Dvc2, animated: true)
        Dvc2.getTitle3 = getTitle
        Dvc2.getLocation3 = getLocation
        Dvc2.getDate3 = getDate
        Dvc2.getName3 = getName2
        Dvc2.getEmail3 = getEmail2
        Dvc2.getMobNo3 = getMob2
        
        print(Dvc2)
        
    }
    
    var rssItem:[Event]?
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLbl.text = getTitle
        bodyLbl.text = getbody
      img.image = getImage
        date.text = getDate
        location.text = getLocation
     //style code
        navigationController?.navigationBar.prefersLargeTitles = false
      print(getImage)
        print(getTitle)
    }
    
    
}
