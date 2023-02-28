//
//  File.swift
//  FindBookTests
//
//  Created by Tiago Santos on 28/02/2023.
//

import Foundation

@testable import FindBook

class MockSearchService: SearchService {
    
    func search(with text: String, completionHandler: @escaping (Result<[FindBook.BookInfo], Error>) -> Void) {
        completionHandler(.success([
            BookInfo(
                title: "Title",
                isbn: nil,
                numberOfPages: 100,
                contributor: nil,
                authorName: nil,
                key: "key",
                editionCount: 2,
                coverId: 123456
            )
        ]))
    }
    
}
