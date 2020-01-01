
import UIKit
import SafariServices

class english_events: UIViewController {
    
    var getName = String()
    var getMob = String()
    var getEmail = String()
    
    
    @IBOutlet weak var newsTableView: UITableView!
    
    var events = [Events]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFromAPI()
    }
    
    func getDataFromAPI() {
        var request = URLRequest(url: URL(string: "https://event.kku.edu.sa/ws/events-en.json")!)
        
        
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




extension english_events: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if events != nil {
            return events.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        cell.title.text = events[indexPath.row].event?.title
        cell.date.text = events[indexPath.row].event?.field_date
        
        tableView.separatorColor = UIColor.black
        
        
     
        if let imageUrlString = events[indexPath.row].event?.field_logo?.src , let imageUrl = URL(string: (imageUrlString)) {
            cell.imageNews.load(url: imageUrl )
            
        }

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TableViewCell

        
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let Dc = Storyboard.instantiateViewController(withIdentifier: "DetailViewController_EN") as! DetailViewController_EN
        Dc.getTitle = (events[indexPath.row].event?.title)!
        Dc.getbody = (events[indexPath.row].event?.body)!
        Dc.getdate = (events[indexPath.row].event?.field_date)!
        Dc.getLocation = (events[indexPath.row].event?.field_location)!
        Dc.getImage =  cell.imageNews.image
        Dc.getName2 = getName
        Dc.getMob2 = getMob
        Dc.getEmail2 = getEmail
        self.navigationController?.pushViewController(Dc, animated: true)
     //  performSegue(withIdentifier: "detail", sender: tableView)
        
    }

}

extension english_events: UITableViewDelegate {
    
    
    }


