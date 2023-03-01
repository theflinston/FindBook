//
//  BookInfoViewControllerViewModelTests.swift
//  FindBookTests
//
//  Created by Tiago Santos on 01/03/2023.
//

import XCTest

@testable import FindBook

final class BookInfoViewControllerViewModelTests: XCTestCase {

    private var sut: BookInfoViewControllerViewModel!
    
    override func setUpWithError() throws {
        let bookInfo =  BookInfo(
            title: "Book Title",
            isbn: nil,
            numberOfPages: 100,
            contributor: nil,
            authorName: nil,
            key: "key",
            editionCount: 2,
            coverId: 123456
        )
        sut = BookInfoViewControllerViewModel(bookInfo: bookInfo)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testTitle() {
        XCTAssertEqual(sut.title, "Book Title")
    }

}
