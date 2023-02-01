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
    let imageURL: URL?
    var imageData: Data? = nil
    
    init(
        title: String,
        description: String,
        imageURL: URL?
    ) {
        self.title = title
        self.description = description
        self.imageURL = imageURL
    }
}
