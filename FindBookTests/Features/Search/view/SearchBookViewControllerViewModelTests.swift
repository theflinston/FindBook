//
//  SearchBookViewControllerViewModelTests.swift
//  FindBookTests
//
//  Created by Tiago Santos on 25/02/2023.
//

import XCTest

@testable import FindBook

final class SearchBookViewControllerViewModelTests: XCTestCase {
    
    private var mockSearchService = MockSearchService()
    private var sut: SearchBookViewControllerViewModel!

    override func setUpWithError() throws {
        sut = SearchBookViewControllerViewModel(service: mockSearchService)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testTitle() {
        XCTAssertEqual(sut.title, "Search")
    }

    func testSearchBarPlaceholder() {
        XCTAssertEqual(sut.searchBarPlaceholder, "Search for books, authors and more")
    }

    func testNumberOfRows() {
        // when
        sut.onSearchAction(with: "text")
        
        // then
        XCTAssertEqual(sut.numberOfRows(inSection: 0), 1)
    }
    
}
