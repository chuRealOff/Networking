//
//  ViewController.swift
//  Networking
//
//  Created by CHURILOV DMITRIY on 05.12.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func getRequest(_ sender: Any) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            guard let response = response,
            let data = data else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data)
                    print(response)
                    print(json)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    @IBAction func postRequest(_ sender: Any) {
        
    }
    

    
}
