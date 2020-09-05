//
//  ListViewController.swift
//  MobileAxxessChallenge
//
//  Created by Nupur Parekh on 03/09/20.
//  Copyright © 2020 Nupur Parekh. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {

    private let cellId="Cell"
    var listArr=[ListDM]()
    var actIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    lazy var listVM : ListVM = {
        let viewModel = ListVM()
        return viewModel
    }()
    lazy var detailsVC : ListDetailsViewController = {
        let details = ListDetailsViewController()
        return details
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        self.tableView.register(ListCell.self, forCellReuseIdentifier: cellId)
        self.actIndicator.frame = CGRect(x:0, y:0, width: 100, height: 100)
        self.actIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        self.actIndicator.center = self.view.center
        self.actIndicator.hidesWhenStopped = true
        self.view.addSubview(self.actIndicator)
        self.title = "List"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.getListData()
    }
    
    // MARK: - fetch data
    func getListData() {
        self.startLoader()
        self.listVM.onErrorHandling = { [weak self] error in
            self?.stopLoader()
            self?.showErrorAlert(alertMessage: error ?? "")
        }
        self.listVM.onSuccessHandling = { [weak self] success in
            DispatchQueue.main.async {
                self?.stopLoader()
                self?.listArr=success
                self?.tableView.reloadData()
            }
        }
        self.listVM.getListData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listArr.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ListCell
        cell.updateCellUI(obj: listArr[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if listArr[indexPath.row].type == "image" {
            return 110
        } else {
            let txtdata = (listArr[indexPath.row].data ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
            let txtHeight=(txtdata.height(withConstrainedWidth: (UIScreen.main.bounds.width-120), font: UIFont.systemFont(ofSize: 15))) + 20
            if txtHeight < 44 {
                return 44
            } else if txtHeight > 80 {
                return 80
            } else {
                return txtHeight
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if listArr[indexPath.row].type != "image" {
            let txtdata = (listArr[indexPath.row].data ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
            if txtdata.count == 0 {
                self.showErrorAlert(alertMessage: "No data found")
                return
            }
        }
        detailsVC.listObj=listArr[indexPath.row]
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }

    // MARK: - UI controlling
    
    func startLoader() {
        DispatchQueue.main.async {
            self.actIndicator.startAnimating()
        }
    }
    
    func stopLoader() {
        DispatchQueue.main.async {
            self.actIndicator.stopAnimating()
        }
    }

}
