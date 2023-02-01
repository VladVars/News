//
//  Model.swift
//  News
//
//  Created by VladVarsotski on 1.02.23.
//

import Foundation

struct APIResponse: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
    let content: String?
}

struct Source: Codable {
    let name: String
}
