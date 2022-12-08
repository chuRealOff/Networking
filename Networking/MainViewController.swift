//
//  MainViewController.swift
//  Networking
//
//  Created by CHURILOV DMITRIY on 07.12.2022.
//

import UIKit

private let url = "https://jsonplaceholder.typicode.com/posts"

class MainViewController: UICollectionViewController {
//    let actions = ["Download Image", "GET", "POST", "Our Courses", "Upload Image"]
    let actions = Actions.allCases

    

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        actions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.label.text = actions[indexPath.row].rawValue
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let action = actions[indexPath.row]
        
        switch action {
        case .downloadImage:
            performSegue(withIdentifier: "showImage", sender: self)
        case .getRequest:
            NetworkManager.getRequest(urlString: url)
        case .postRequest:
            NetworkManager.postRequest(urlString: url)
        case .ourCourses:
            performSegue(withIdentifier: "showCourses", sender: self)
        case .uploadImage:
             print("Upload Image")
        }
    }

}
