//
//  EmployeeListScreen2.swift
//  Employee Directory
//
//  Created by Randy Varela on 2/19/22.
//

import UIKit

class EmployeeListScreen: UIViewController {
    
    var employees: [EmployeeElement] = []

    @IBOutlet weak var tableView: UITableView!
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let url = URL(string: "https://s3.amazonaws.com/sq-mobile-interview/employees.json") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            if error == nil{
                
                do {
                    self.employees = try JSONDecoder().decode(Employee.self, from: data).employees
                } catch let jsonError {
                    print(jsonError)
                }
                
                DispatchQueue.main.async {
                    print(self.employees.count)
                    self.tableView.reloadData()
                }
            }
        }.resume()
    }
        
    }




    
extension EmployeeListScreen: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let employee = employees[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCell") as! EmployeeCell
    
        cell.employeeName.text = employees[indexPath.row].fullName
        //cell.employeeImage.image = employees[indexPath.row].photoURLSmall
        cell.employeeTeam.text = employees[indexPath.row].team
        self.tableView.rowHeight = 150;
        
        let completeLink = employees[indexPath.row].photoURLSmall
        cell.imageView!.downloaded(from: completeLink)
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        
        
        return cell
    }
    @objc private func didPullToRefresh() {
        //refetch data here
        print("Table view is refreshing.")
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
}




extension UIImageView {
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
    
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFill) {
        contentMode = mode
//        if let imageData = ImageCache.shared.images[url.absoluteString], let image = UIImage(data: imageData) {
//            print("Using Cached images")
//            self.image = image
//        } else {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                else { return }
                //ImageCache.shared.images[url.absoluteString] = data
                DispatchQueue.main.async() { [weak self] in
                    
                    self?.image = image
                }
            }.resume()
        }
    }


