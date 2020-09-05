//
//  ListVM.swift
//  MobileAxxessChallenge
//
//  Created by Nupur Parekh on 03/09/20.
//  Copyright © 2020 Nupur Parekh. All rights reserved.
//

import Foundation

public class ListVM {
    weak var service: ServiceManagerProtocol?
    
    var onErrorHandling : ((String?) -> Void)?
    var onSuccessHandling : (([ListDM]) -> Void)?
    
    init(service: ServiceManagerProtocol = ServiceManager.objServiceManager) {
        self.service = service
    }
    
    func getListData() {
        guard let service = self.service else {
            self.onErrorHandling?(GenericError)
            return
        }
        
        if !ReachabilityHelper.reachabilityInstance.isReachable {
            let resp=GetListData()
            if resp.count > 0 {
                let list = convertDBListToResp(dbList: resp)
                self.onSuccessHandling?(list)
            } else {
                self.onErrorHandling?(NetworkError)
                return
            }
        }
        
        service.getListData { (success, message, list) in
            if success {
                var resp=list ?? [ListDM]()
                if resp.count > 0 {
                    let sortedResults = resp.sorted { ($0.type ?? "").lowercased() < ($1.type ?? "").lowercased() }
                    resp=sortedResults
                }
                self.convertAndRespListToSaveToDB(respList: resp)
                self.onSuccessHandling?(resp)
            } else {
                self.onErrorHandling?(message)
            }
        }
    }
    
    //MARK: Converter classes
    
    func convertDBListToResp(dbList:[List]) -> [ListDM] {
        var resp=[ListDM]()
        for obj in dbList {
            let respObj = ListDM.init(id: obj.id, type: obj.type, date: obj.data, data: obj.date)
            resp.append(respObj)
        }
        return resp
    }
    
    func convertAndRespListToSaveToDB(respList:[ListDM]) {
        var dbList=[List]()
        for obj in respList {
            let dbObj=List()
            dbObj.id=(obj.id ?? "")
            dbObj.type=(obj.type ?? "")
            dbObj.data=(obj.data ?? "")
            dbObj.date=(obj.date ?? "")
            dbList.append(dbObj)
        }
        SaveListData(list: dbList)
    }
}
