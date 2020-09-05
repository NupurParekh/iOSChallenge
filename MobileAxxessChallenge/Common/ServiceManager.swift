//
//  ServiceManager.swift
//  MobileAxxessChallenge
//
//  Created by Nupur Parekh on 03/09/20.
//  Copyright © 2020 Nupur Parekh. All rights reserved.
//

import Foundation
import Alamofire

protocol ServiceManagerProtocol : class {
    func getListData(completionHandler: @escaping (_ success:Bool,_ message:String , _ feedData: [ListDM]? ) -> Void)
}

final class ServiceManager: ServiceManagerProtocol {
    
    static let objServiceManager = ServiceManager()
    typealias CompletionHandlerForListData = ( _ success:Bool,_ message:String , _ feedData: [ListDM]?) -> Void
    
    private init() { }
    
    func getListData(completionHandler: @escaping (_ success:Bool,_ message:String , _ feedData: [ListDM]? ) -> Void) {
        
        AF.request(listAPI).responseJSON { (response) in
            
            switch response.result {
            case .success( _):
                let decoder = JSONDecoder()
                do {
                    let respList = try decoder.decode([ListDM].self, from: response.data!)
                    completionHandler(true, "", respList)
                    return
                } catch {
                    completionHandler(false, GenericError, nil)
                    return
                }
                
            case .failure(let error):
                completionHandler(false, error.localizedDescription, nil)
                return
            }
        }
    }
}
