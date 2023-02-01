//
//  NewsTableViewCellViewModel.swift
//  News
//
//  Created by VladVarsotski on 1.02.23.
//

import Foundation

class NewsTableViewCellViewModel {
    let title: String
    let description: String
    let publishedAt: String
    let imageURL: URL?
    var imageData: Data? = nil
    
    init(
        title: String,
        description: String,
        publishedAt: String,
        imageURL: URL?
    ) {
        self.title = title
        self.description = description
        self.publishedAt = publishedAt
        self.imageURL = imageURL
    }
}
