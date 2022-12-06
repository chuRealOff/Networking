//
//  Course.swift
//  Networking
//
//  Created by CHURILOV DMITRIY on 06.12.2022.
//

import Foundation

struct Course: Codable {
    let id: Int
    let name: String
    let link: String
    let imageUrl: String
    let number_of_lessons: Int
    let number_of_tests: Int
}
