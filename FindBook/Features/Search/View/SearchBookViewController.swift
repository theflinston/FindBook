//
//  SearchBookViewController.swift
//  FindBook
//
//  Created by Tiago Santos on 25/02/2023.
//

import UIKit

class SearchBookViewController: UITableViewController {

    private let viewModel: SearchBookViewControllerViewModel
    
    init(viewModel: SearchBookViewControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUiInterface()
        prepareViewModel()
    }
    
    private func addSearch() {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.searchBar.delegate = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = viewModel.searchBarPlaceholder
        search.searchBar.returnKeyType = .search
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = search
    }
    
    private func prepareUiInterface() {
        title = viewModel.title
        addSearch()
    }
    
    private func prepareViewModel() {
        let updateUiInterface = { [weak self] in
            guard let self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        let showBookInformationScreen: ((_ viewModel: BookInfoViewControllerViewModel) -> Void) = {
            [weak self] bookInfoViewControllerViewModel  in
            guard let self else { return }
            DispatchQueue.main.async {
                let bookInfoViewController = BookInfoViewController(viewModel: bookInfoViewControllerViewModel)
                self.navigationController?.pushViewController(bookInfoViewController, animated: true)
            }
        }
        
        viewModel.binding = SearchBookViewControllerViewModelBinding(
            updateUiInterface: updateUiInterface,
            showBookInformationScreen: showBookInformationScreen
        )
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(inSection: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "cellIdentifier"
        
        let cell: UITableViewCell
        if let reusableCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
            cell = reusableCell
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        }
        
        let rowInfo = viewModel.info(for: indexPath)
        cell.textLabel?.text = rowInfo.title
        cell.textLabel?.numberOfLines = 2
        cell.detailTextLabel?.text = rowInfo.author
        cell.accessoryType = .disclosureIndicator
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.onRowSelection(at: indexPath)
    }

}

extension SearchBookViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) { }
}

extension SearchBookViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.onSearchAction(with: searchBar.text)
    }
    
}
