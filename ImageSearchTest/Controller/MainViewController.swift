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
    //private let searchController = UISearchController(searchResultsController: nil)
    // MARK: -
    // MARK: Properties

    private var mainView: MainView? = nil
    private var constr: MainViewConstraints = MainViewConstraints()
    private var model: MainModel = MainModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = MainView()
        self.mainView = view
        self.view = view
        view.paint(color: isTesting ? .green : .white)
        view.setConstr(constraints: self.constr)
        self.mainView?.bottomView?.tableView?.delegate = self
        self.mainView?.bottomView?.tableView?.dataSource = self
        self.mainView?.bottomView?.tableView?.register(ImageTableViewCell.self, forCellReuseIdentifier: self.cellID)
        self.mainView?.bottomView?.tableView?.allowsSelection = true
        
        self.model.toDoIfDataChanges = {
            self.model.data = self.model.data.filter{ data in
                return (data.image != nil) 
            }
           // self.model.data.append(contentsOf: self.model.data)
            //self.mainView?.bottomView?.tableView?.setNeedsLayout()
            //self.mainView?.bottomView?.tableView?.layoutIfNeeded()
            
          //  UIView.setAnimationsEnabled(false)
          //  self.mainView?.bottomView?.tableView?.beginUpdates()
            self.mainView?.bottomView?.tableView?.reloadData()
           // self.mainView?.bottomView?.tableView?.endUpdates()
          //  UIView.setAnimationsEnabled(true)
           
            
        }
        self.mainView?.upperView?.searchBar?.delegate = self
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillLayoutSubviews() {
        self.mainView?.layoutSubviews()
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
        let info = self.model.data.reversed()[indexPath.row]//.suffix(from: indexPath.row).first
        cell.setData(text: info.name, image: info.image)
        /*cell.setData(text: "There is no images", image: data)
        if let url = URL(string: "https://images.unsplash.com/photo-1541093113199-a2e9d84e903f?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=100&fit=max&ixid=eyJhcHBfaWQiOjkyNTc5fQ") {
            downloadImage(from: url){ (data) in
                //self.searchImage?.image = UIImage(data: data)
                // self.layoutSubviews()
                
                
            }
        }
        // */
        
        //cell.searchImage = UIImageView(image: self.imageForTest)
        cell.setConstr(constraints: constr.imageTableViewCellConstraints)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return constr.imageTableViewCellConstraints.cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return
    }
    

}

