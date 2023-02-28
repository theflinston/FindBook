//
//  SearchBookViewControllerViewModel.swift
//  FindBook
//
//  Created by Tiago Santos on 25/02/2023.
//

import Foundation

struct SearchBookViewControllerViewModelBinding {
    var updateUiInterface: () -> Void
    var showBookInformationScreen: (_ viewModel: BookInfoViewControllerViewModel) -> Void
}

final class SearchBookViewControllerViewModel {
    
    var binding: SearchBookViewControllerViewModelBinding?
    
    private var searchResults = [BookInfo]() {
        didSet {
            self.binding?.updateUiInterface()
        }
    }
    
    private let service: SearchService
    
    init(service: SearchService) {
        self.service = service
    }
    
    private func search(using text: String) {
        service.search(
            with: text) { [weak self] result in
                guard let self else { return }
                switch result {
                    case .success(let results):
                        self.searchResults = results
                    case .failure(_):
                        // TODO: handle error
                        break
                }
            }
    }
    
    var title: String {
        return "Search"
    }
    
    var searchBarPlaceholder: String {
        return "Search for books, authors and more"
    }
    
    func numberOfRows(inSection: Int) -> Int {
        return searchResults.count
    }
    
    func onSearchAction(with searchText: String?) {
        guard let searchText else { return }
        search(using: searchText)
    }
    
    typealias RowPresentableInfo = (title: String, author: String?)
    
    func info(for indexPath: IndexPath) -> RowPresentableInfo {
        let searchResult = searchResults[indexPath.row]
        return (searchResult.title, searchResult.authorName?.first)
    }
    
    func onRowSelection(at indexPath: IndexPath) {
        
        let selectedBookInfo = searchResults[indexPath.row]
        let bookInfoViewControllerViewModel = BookInfoViewControllerViewModel(bookInfo: selectedBookInfo)
        binding?.showBookInformationScreen(bookInfoViewControllerViewModel)
        
    }
}
