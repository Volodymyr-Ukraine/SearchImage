//
//  ViewController.swift
//  ImageSearchTest
//
//  Created by Vladimir on 9/20/19.
//  Copyright © 2019 Volodymyr. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    private let cellID = "images"
    private var imageForTest: UIImage? = nil
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        get {
            return UIInterfaceOrientationMask.all
        }
    }
    
    // MARK: -
    // MARK: Properties

    private var mainView: MainView? = nil
    private var constr: MainViewConstraints = MainViewConstraints()
    private var model: MainModel = MainModel()
    
    // MARK: -
    // MARK: Init and Preparing
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = MainView()
        self.mainView = view
        self.view = view
        view.paint(color: isTesting ? .green : backgroundWhiteColor)
        view.setConstr(constraints: self.constr)
        let table = self.mainView?.bottomView?.tableView
        table?.delegate = self
        table?.dataSource = self
        table?.register(ImageTableViewCell.self, forCellReuseIdentifier: self.cellID)
        table?.allowsSelection = true
        self.model.toDoIfDataChanges = {
            self.mainView?.bottomView?.tableView?.reloadData()
        }
        self.mainView?.upperView?.searchBar?.delegate = self
        self.hideKeyboardWhenTappedAround()
    }

    // MARK: -
    // MARK: Methods
    
    internal func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let text = searchBar.text ?? ""
        self.model.readURL(search: text)
    }
    
    private func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.mainView?.bottomView?.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    // MARK: -
    // MARK: Table Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath) as? ImageTableViewCell) ?? ImageTableViewCell()
        if let info = self.model.data.reversed().suffix(from: indexPath.row).first {
            cell.setData(text: info.name, image: info.image)
        }
        cell.setConstr(constraints: constr.imageTableViewCellConstraints)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return constr.imageTableViewCellConstraints.cellHeight
    }
}

