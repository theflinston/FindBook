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
    
    func testOnSearchAction() {
        //given
        let  updateUiInterfaceCalledExpectation = expectation(description: "Wait for interface to be updated")
        
        sut.binding = SearchBookViewControllerViewModelBinding(
            updateUiInterface: {
                updateUiInterfaceCalledExpectation.fulfill()
            },
            showBookInformationScreen: { _ in }
        )
        
        // when
        sut.onSearchAction(with: "text")
        
        // then
        wait(for: [updateUiInterfaceCalledExpectation], timeout: 0.5)
        
        XCTAssertEqual(sut.numberOfRows(inSection: 0), 1)
    }
    
    func testInfo() {
        //given
        sut.onSearchAction(with: "text")
        let indexPath = IndexPath(row: 0, section: 0)
        
        // when
        let rowInfo = sut.info(for: indexPath)
        
        // then
        XCTAssertEqual(rowInfo.title, "Title")
        XCTAssertNil(rowInfo.author)
    }
    
    func testOnRowSelection() {
        //given
        let  showBookInformationScreenExpectation = expectation(description: "Wait for showBookInformationScreen to be called")
        
        
        sut.binding = SearchBookViewControllerViewModelBinding(
            updateUiInterface: { },
            showBookInformationScreen: { _ in
                showBookInformationScreenExpectation.fulfill()
            }
        )
        
        sut.onSearchAction(with: "text")
        let indexPath = IndexPath(row: 0, section: 0)
        
        // when
        sut.onRowSelection(at: indexPath)
        
        // then
        wait(for: [showBookInformationScreenExpectation], timeout: 0.5)
    }
    
}
