//
//  RealmHelper.swift
//  MobileAxxessChallenge
//
//  Created by Nupur Parekh on 03/09/20.
//  Copyright © 2020 Nupur Parekh. All rights reserved.
//

import Foundation
import RealmSwift

let realm = try! Realm()

class List: Object
{
    @objc dynamic var id       : String!           =       ""
    @objc dynamic var type     : String!           =       ""
    @objc dynamic var date     : String!           =       ""
    @objc dynamic var data     : String!           =       ""
}

func SaveListData(list:[List])
{
    DispatchQueue.main.async {
        DeleteListData()
        do {
            try! realm.write {
                realm.add(list)
            }
        }
    }
}


func GetListData() -> [List]
{
    let list = realm.objects(List.self)
    return Array(list)
}

func DeleteListData()
{
    let listObjects = realm.objects(List.self)
    
    try! realm.write {
        realm.delete(listObjects)
    }
}
