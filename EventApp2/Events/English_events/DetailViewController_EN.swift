//
//  DetailViewController_EN.swift
//  DecodableWithTableview
//
//  Created by Bdoor on 24/07/1440 AH.
//  Copyright © 1440 X901. All rights reserved.
//

import UIKit

class DetailViewController_EN: UIViewController {
    var getTitle = String()
    var getbody = String()
    var getdate = String()
    var getLocation = String()
    //var name = ""
    var getImage : UIImage!
    var getEmail2 = String()
    var getMob2 = String()
    var getName2 = String()
    
    

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var bodyLabel: UITextView!
    
    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var locationLbl: UILabel!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLbl.text = getTitle
       bodyLabel.text = getbody
        img.image = getImage
        dateLbl.text = getdate
        locationLbl.text = getLocation
        
        //navigationController?.navigationBar.prefersLargeTitles = false
        

        // Do any additional setup after loading the view.
    }
    

    @IBAction func reservation_En(_ sender: Any) {
        let Dvc2 = storyboard!.instantiateViewController(withIdentifier: "reservation") as! reservation
        self.navigationController?.pushViewController(Dvc2, animated: true)
        Dvc2.getTitle3 = getTitle
        Dvc2.getLocation3 = getLocation
        Dvc2.getDate3 = getdate
        Dvc2.getName3 = getName2
        Dvc2.getEmail3 = getEmail2
        Dvc2.getMobNo3 = getMob2
        
    }
    

}
