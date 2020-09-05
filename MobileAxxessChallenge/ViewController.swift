//
//  ViewController.swift
//  MobileAxxessChallenge
//
//  Created by Nupur Parekh on 03/09/20.
//  Copyright © 2020 Nupur Parekh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let cellId="Cell"
    lazy var listVM : ListVM = {
        let viewModel = ListVM()
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        let tblView = UITableView.init(frame: self.view.frame)
        tblView.dataSource = self
        tblView.separatorStyle = .none
        self.view.addSubview(tblView)
        tblView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
//        tblView.snp.makeConstraints { (make) -> Void in
//           make.width.height.equalTo(50)
//           make.center.equalTo(self.view)
//        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let currentLastItem = "Cell - \(indexPath.row)"
        cell.textLabel?.text = currentLastItem
        return cell
    }
}

