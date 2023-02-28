//
//  SearchResult.swift
//  FindBook
//
//  Created by Tiago Santos on 27/02/2023.
//

import Foundation

struct BookInfo: Decodable {
    let title: String
    let isbn: [String]?
    let numberOfPages: Int?
    let contributor: [String]?
    let authorName: [String]?
    let key: String
    let editionCount: Int
    let coverId: Int?
    
    enum CodingKeys: String, CodingKey {
        case title
        case isbn
        case numberOfPages = "number_of_pages_median"
        case contributor
        case authorName = "author_name"
        case key
        case editionCount = "edition_count"
        case coverId = "cover_i"
    }
}
