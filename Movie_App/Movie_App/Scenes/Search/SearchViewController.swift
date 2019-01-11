//
//  SearchViewController.swift
//  Movie_App
//
//  Created by MAC110 on 1/9/19.
//  Copyright © 2019 MAC110. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MGSwipeTableCell
class SearchViewController: BaseViewController {
    
    var viewModel: SearchViewModel!
    
    @IBOutlet weak private var tblHistory: UITableView!{
        didSet{
            tblHistory.tableFooterView = UIView()
        }
    }
    
    private lazy var searchBar: UISearchBar = {
        let searchbar = UISearchBar()
        searchbar.showsCancelButton = true
        if let txfSearchField = searchbar.value(forKey: "_searchField") as? UITextField {
            txfSearchField.borderStyle = .none
            txfSearchField.backgroundColor = .white
            txfSearchField.cornerRadius = 15
            txfSearchField.rx.controlEvent([.editingDidEndOnExit])
                .bind(to: viewModel.searchDidTapped)
                .disposed(by: disposeBag)
        }
        searchbar.tintColor = Colors.white
        searchbar.placeholder = "Search Movie"
        return searchbar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.searchBar.becomeFirstResponder()
    }
}

//MARK: - Setup
extension SearchViewController{
    private func setup(){
        self.setupUI()
        self.setupBinding(viewModel: self.viewModel)
    }
    
    private func setupUI(){
        self.navigationController?.navigationBar.barTintColor = Colors.searchNavigationBar
        self.navigationItem.hidesBackButton = true
        self.navigationItem.titleView = searchBar
        self.tblHistory.inputAccessoryView?.backgroundColor = .black
    }
    
    private func setupBinding(viewModel: SearchViewModel){
        super.setupBindingForBaseViewModel(viewModel: viewModel)
        self.searchBar.rx.cancelButtonClicked
            .bind(to: viewModel.dismiss)
            .disposed(by: disposeBag)
        self.searchBar.rx.text.orEmpty
            .bind(to: viewModel.searchString)
            .disposed(by: disposeBag)
        self.viewModel.searchHistory
            .bind(to: tblHistory.rx.items(cellIdentifier: "cell", cellType: MGSwipeTableCell.self)) { row, element, cell in
                cell.textLabel?.text = element
                cell.selectionStyle = .none
                cell.delegate = self
            }.disposed(by: disposeBag)
        self.tblHistory
            .rx
            .modelSelected(String.self)
            .bind(to: viewModel.selectedKeyword)
            .disposed(by: disposeBag)
    }
}
extension SearchViewController: MGSwipeTableCellDelegate {
    func swipeTableCell(_ cell: MGSwipeTableCell, canSwipe direction: MGSwipeDirection) -> Bool {
        switch direction {
        case .rightToLeft:
            return true
        case .leftToRight:
            return false
        }
    }
    
    func swipeTableCell(_ cell: MGSwipeTableCell, swipeButtonsFor direction: MGSwipeDirection, swipeSettings: MGSwipeSettings, expansionSettings: MGSwipeExpansionSettings) -> [UIView]? {
        
        guard let indexPath = self.tblHistory.indexPath(for: cell) else {
            return nil
        }
        swipeSettings.transition = MGSwipeTransition.border
        expansionSettings.buttonIndex = 0
        expansionSettings.fillOnTrigger = false
        expansionSettings.threshold = 2
        let padding = 20
        let delete = MGSwipeButton(title: "", icon: UIImage(named: "delete"), backgroundColor: .gray, padding: padding) { [weak self] (cell) -> Bool in
            guard let `self` = self else { return true}
            self.viewModel.deleteElement(for: indexPath)
            return true
        }
        return [delete]
    }
}

