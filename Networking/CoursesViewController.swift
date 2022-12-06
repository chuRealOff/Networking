//
//  CoursesViewController.swift
//  Networking
//
//  Created by CHURILOV DMITRIY on 06.12.2022.
//

import UIKit

class CoursesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Courses"
        fetchData()
    }
    
    func fetchData() {
        let jsonUrlString = "https://swiftbook.ru//wp-content/uploads/api/api_courses"
        guard let url = URL(string: jsonUrlString) else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            let jsonDecoder = JSONDecoder()
            
            do {
                let courses = try jsonDecoder.decode([Course].self, from: data)
                print(courses)
            } catch let error {
                print("Error serialization json", error)
            }
        }.resume()
    }
    


}
