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
    let pubDate: String
    let content: String
    let image_url: URL?
    var imageData: Data? = nil
    
    init(
        title: String,
        description: String,
        pubDate: String,
        content: String,
        image_url: URL?
    ) {
        self.title = title
        self.description = description
        self.pubDate = pubDate
        self.content = content
        self.image_url = image_url
    }
}
