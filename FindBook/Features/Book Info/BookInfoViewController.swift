//
//  BookInfoViewController.swift
//  FindBook
//
//  Created by Tiago Santos on 28/02/2023.
//

import UIKit

class BookInfoViewController: UIViewController {
    
    private let viewModel: BookInfoViewControllerViewModel
    
    init(viewModel: BookInfoViewControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = viewModel.title
    }

}
