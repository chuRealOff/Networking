//
//  ViewController.swift
//  Networking
//
//  Created by CHURILOV DMITRIY on 05.12.2022.
//

import UIKit

private let url = "https://applelives.com/wp-content/uploads/2016/03/iPhone-SE-11.jpeg"

class ImageViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        activityIndicator.hidesWhenStopped = true
        fetchImage()
    }
    
    func fetchImage() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        NetworkManager.downloadImage(urlString: url) { image in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.imageView.image = image
            }
        }
    }
    
    
}









