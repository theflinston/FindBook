//
//  SearchService.swift
//  FindBook
//
//  Created by Tiago Santos on 25/02/2023.
//

import Foundation

protocol SearchService {
    func search(with text: String, completionHandler: @escaping (Result< [BookInfo], Error>) -> Void )
    
    func cancel()
}

