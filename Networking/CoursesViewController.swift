//
//  CoursesViewController.swift
//  Networking
//
//  Created by CHURILOV DMITRIY on 06.12.2022.
//

import UIKit

private let jsonUrlString = "https://swiftbook.ru//wp-content/uploads/api/api_courses"

class CoursesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var courses = [Course]()
    private var courseName: String?
    private var courseUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Courses"
        tableView.delegate = self
        fetchData()
    }
    
    func fetchData() {
        NetworkManager.fetchCollectionViewData(urlString: jsonUrlString) { courses in
            self.courses = courses
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let webViewController = segue.destination as! WebViewController
        webViewController.selectedCourse = courseName
        if let courseUrl = courseUrl {
            webViewController.coursrURL = courseUrl
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let course = courses[indexPath.row]
        courseName = course.name
        courseUrl = course.link
        
        performSegue(withIdentifier: "particularCourse", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
}
