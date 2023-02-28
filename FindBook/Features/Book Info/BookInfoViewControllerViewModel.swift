//
//  BookInfoViewControllerViewModel.swift
//  FindBook
//
//  Created by Tiago Santos on 28/02/2023.
//

import UIKit

final class BookInfoViewControllerViewModel {

    private let bookInfo: BookInfo
    
    init(bookInfo: BookInfo) {
        self.bookInfo = bookInfo
    }
    
    var title: String {
        return bookInfo.title
    }

}
