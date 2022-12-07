//
//  NetworkManager.swift
//  Networking
//
//  Created by CHURILOV DMITRIY on 07.12.2022.
//

import UIKit

class NetworkManager {
    
    static func getRequest(urlString: String) {
        guard let url = URL(string: urlString) else { return }
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
    
    static func postRequest(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        let userData = ["Course": "Networking", "Lesson": "GET and POST Requests"]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: userData) else { return }
        request.httpBody = httpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response else { return }
            print(response)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data)
                print(json)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    static func downloadImage(urlString: String, completion: @escaping (_ image: UIImage) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            }
        }.resume()
    }
    
    static func fetchCollectionViewData(urlString: String, completion: @escaping ([Course]) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let courses = try jsonDecoder.decode([Course].self, from: data)
                completion(courses)
            } catch let error {
                print("Error serialization json", error)
            }
        }.resume()
    }
    
}
