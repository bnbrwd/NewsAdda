//
//  NewsData.swift
//  NewsAdda
//
//  Created by Bindeshwari Narayan on 20/11/21.
//

import Foundation

struct NewsDomaindata : Codable {
    
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let author: String?
    var title, articleDescription: String
    let url: String
    let urlToImage: String
    let publishedAt: String
    let content: String
    
    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
    
    init(source: Source,author: String,title: String,articleDescription: String,url: String,urlToImage: String, publishedAt: String, content: String) {
        
        self.source = source
        self.author = author
        self.title = title
        self.articleDescription = articleDescription
        self.url = url
        self.title = title
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
    
    
}


struct Source: Codable {
    let id: String?
    let name: String
}
