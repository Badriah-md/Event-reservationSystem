////
//ViewController.swift
//DecodableWithTableview
//
//Created by
//Copyright © 2019 ts reserved.
//

import UIKit
import SafariServices


class arabic_events: UIViewController ,UITableViewDelegate,finalDelegate{
    func finishPassing(string: String) {
        print(string)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? reservation{
            destination.delegate = self
        }
    }
    
    
    @IBAction func english(_ sender: Any){
        
    }
    var searchArray = [String]()
    var events = [Events]()
     @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var searchbar: UISearchBar!
    var prepareImage = String()
    var getName = String()
    var getMob = String()
    var getEmail = String()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! TableViewCell

       
        let Dvc = storyboard!.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        self.navigationController?.pushViewController(Dvc, animated: true)
       
        
       //let Rvc = storyboard!.instantiateViewController(withIdentifier: "reservation") as! reservation
      //self.navigationController?.pushViewController(Rvc, animated: false)
        Dvc.getTitle = (events[indexPath.row].event?.title)!
        Dvc.getbody = (events[indexPath.row].event?.body)!
        Dvc.getDate = (events[indexPath.row].event?.field_date)!
        Dvc.getLocation = (events[indexPath.row].event?.field_location)!
        Dvc.getImage =  cell.imageNews.image
        Dvc.getName2 = getName
        Dvc.getMob2 = getMob
        Dvc.getEmail2 = getEmail
        
        print(Dvc)
      
            }
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFromAPI()
        navbar()
        self.navigationItem.setHidesBackButton(true, animated: false)
       
    }
    
    
    func navbar(){
        navigationController?.navigationBar.prefersLargeTitles = false
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationController?.navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = nil
        navigationItem.leftBarButtonItem = nil
        
    }
    
    func getDataFromAPI() {
        var request = URLRequest(url: URL(string: "https://event.kku.edu.sa/ws/events-ar.json")!)
        
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            
            guard let data = data else {return }
            
            
            
            do{
                let JSONResponse = try JSONDecoder().decode(Json4Swift_Base.self, from: data)
                print(JSONResponse)
                
                self.events = JSONResponse.events!
                
                
                DispatchQueue.main.async {
                    self.newsTableView.reloadData()
                }
                
                
            } catch  {
                print(error.localizedDescription)
            }
            
        }
        task.resume()
        
    }
    
    
    func openUrlInSafari(url:URL) {
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)
    }
    
}


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}




extension arabic_events: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if events != nil {
            return events.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.layer.cornerRadius = cell.bounds.width / 30
        cell.title.text = events[indexPath.row].event?.title
        cell.date.text = events[indexPath.row].event?.field_date
       
        if let imageUrlString = events[indexPath.row].event?.field_logo?.src , let imageUrl = URL(string: (imageUrlString)) {
            cell.imageNews.load(url: imageUrl )
           
        }
        
        return cell
    }
    
}



extension arabic_events:UISearchBarDelegate{
    private func searchBar(_ searchBar: UISearchBar, textDidChange searchText: Substring) {
        //searchArray = (events.filter({$0.event?.title.prefix(searchText.count) == searchText}) as? [String])!
    }
}
