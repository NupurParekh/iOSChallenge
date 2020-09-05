//
//  ListCell.swift
//  MobileAxxessChallenge
//
//  Created by Nupur Parekh on 03/09/20.
//  Copyright © 2020 Nupur Parekh. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class ListCell: UITableViewCell {
    
    var listObj : ListDM!
    private let  mainView : UIView = {
        let mainvw=UIView.init()
        mainvw.backgroundColor=UIColor.white
        mainvw.layer.borderWidth = 1
        mainvw.layer.cornerRadius = 6
        mainvw.layer.borderColor = UIColor.lightGray.cgColor
        return mainvw
    }()
    
    private let listData : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.textAlignment = .left
        lbl.numberOfLines = 3
        return lbl
    }()
    
    private var listDate : UILabel =  {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .right
        label.textColor = .black
        return label
    }()
    
    private let listImage : UIImageView = {
        let imgView = UIImageView.init()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        mainView.frame=self.bounds
        addSubview(mainView)
        mainView.addSubview(listDate)
        self.selectionStyle = .none
        mainView.snp.makeConstraints { (make) -> Void in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(6)
            make.bottom.equalToSuperview().offset(-6)
            make.right.equalToSuperview().offset(-10)
        }
        
        listDate.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(80)
            make.height.equalTo(22)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(5)
        }
        self.backgroundColor=UIColor.blue.withAlphaComponent(0.2)
    }
    
    func updateCellUI(obj: ListDM) {
        self.listDate.text = obj.date
        listData.removeFromSuperview()
        listImage.removeFromSuperview()
        if obj.type == "image" {
            self.listImage.kf.setImage(with: URL(string: obj.data ?? ""))
            mainView.addSubview(listImage)
            listImage.snp.makeConstraints { (make) -> Void in
                make.width.equalTo(120)
                make.height.equalTo(80)
                make.leading.equalToSuperview().offset(10)
                make.centerY.equalTo(mainView)
            }
            if self.listImage.image == nil {
                self.listImage.image=UIImage(named: "placeholder")
            }
        } else {
            mainView.addSubview(listData)
            self.listData.text = (obj.data ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
            listData.snp.makeConstraints { (make) -> Void in
                make.left.equalToSuperview().offset(10)
                make.top.equalToSuperview().offset(5)
                make.right.equalToSuperview().offset(-100)
                make.height.equalTo(22).priority(500)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
