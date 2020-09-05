//
//  ListDetailsViewController.swift
//  MobileAxxessChallenge
//
//  Created by Nupur Parekh on 05/09/20.
//  Copyright © 2020 Nupur Parekh. All rights reserved.
//

import UIKit
import Kingfisher

class ListDetailsViewController: UIViewController {

    var listObj:ListDM!
    
    private let listData : UITextView = {
        let txtData = UITextView()
        txtData.textColor = .black
        txtData.font = UIFont.systemFont(ofSize: 15)
        txtData.isSelectable = false
        txtData.isEditable = false
        txtData.layer.borderWidth = 1
        txtData.layer.cornerRadius = 6
        txtData.layer.borderColor = UIColor.lightGray.cgColor
        return txtData
    }()
    
    private var listDate : UILabel =  {
        let lblDate = UILabel()
        lblDate.font = UIFont.systemFont(ofSize: 14)
        lblDate.textAlignment = .right
        lblDate.textColor = .black
        return lblDate
    }()
    
    private let listImage : UIImageView = {
        let imgView = UIImageView.init()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Details"
        view.backgroundColor = .white
        self.view.addSubview(listDate)
        self.view.addSubview(listData)
        self.view.addSubview(listImage)
        listDate.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(80)
            make.height.equalTo(22)
            make.top.equalToSuperview().offset(80)
            make.right.equalToSuperview().offset(-10)
        }
        
        listImage.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(340)
            make.height.equalTo(200)
            make.centerX.equalTo(self.view)
            make.top.equalToSuperview().offset(120)
        }
        
        listData.snp.makeConstraints { (make) -> Void in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(100)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.listDate.text=listObj.date
        if listObj.type == "image" {
            self.listImage.isHidden = false
            self.listData.isHidden = true
            self.listImage.image=UIImage(named: "placeholder")
            self.listImage.kf.setImage(with: URL(string: listObj.data ?? ""))
            if self.listImage.image == nil {
                self.listImage.image=UIImage(named: "placeholder")
            }
        } else {
            self.listImage.isHidden = true
            self.listData.isHidden = false
            self.listData.text=(listObj.data ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }

}
