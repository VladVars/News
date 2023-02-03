//
//  Model.swift
//  News
//
//  Created by VladVarsotski on 1.02.23.
//

import Foundation

struct APIResponse: Codable {
    let results: [Article]
}

struct Article: Codable {
    let title: String
    let description: String?
    let link: String?
    let image_url: String?
    let pubDate: String
    let content: String?
}
