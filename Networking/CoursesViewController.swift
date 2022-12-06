//
//  CoursesViewController.swift
//  Networking
//
//  Created by CHURILOV DMITRIY on 06.12.2022.
//

import UIKit

class CoursesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var courses = [Course]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Courses"
        tableView.delegate = self
        fetchData()
    }
    
    func fetchData() {
        let jsonUrlString = "https://swiftbook.ru//wp-content/uploads/api/api_courses"
        guard let url = URL(string: jsonUrlString) else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                self.courses = try jsonDecoder.decode([Course].self, from: data)
               
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch let error {
                print("Error serialization json", error)
            }
        }.resume()
    }
    
    private func configureCell(_ cell: CourseCell, forIndexPath indexPath: IndexPath) {
        let course = courses[indexPath.row]
        cell.courseNameLabel .text = course.name
        
        if let numberOfLessons = course.numberOfLessons,
           let numberOfTests = course.numberOfTests {
            cell.numberOfLessonsLabel.text = "Number of lessons: \(numberOfLessons)"
            cell.numberOfTestsLabel.text = "Number of tests: \(numberOfTests)"
            
            DispatchQueue.global().async {
                guard let imageUrl = URL(string: course.imageUrl) else { return }
                guard let imageData = try? Data(contentsOf: imageUrl) else { return }
   
                DispatchQueue.main.async {
                    cell.picture.image = UIImage(data: imageData)
                    
                }
            }
        }
    }
}

//MARK: Table view data source

extension CoursesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CourseCell
        configureCell(cell, forIndexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
}
