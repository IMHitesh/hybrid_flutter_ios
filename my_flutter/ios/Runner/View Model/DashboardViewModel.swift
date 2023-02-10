//
//  File.swift
//
//
//  Created by Hitesh Surani on 16/01/23.
//

import Foundation
import SVProgressHUD


protocol DashboardDelegate: BaseViewModelDelegate {
    func onLogoutSuccess()
}

class DashboardViewModel: BaseViewModel{    
    var delegate: DashboardDelegate?
    
    var users: [User] = []
    
    override init() {
        super.init()
        addObserver()
    }
    
    deinit {
        removeObserver()
    }
    
    func getDashboardData(){
        SVProgressHUD.show()
        AppViewModel.shared.triggerFlutterMethod(action: .getDashboardData)
    }
    
    func onLogoutClick(){
        SVProgressHUD.show()
        AppViewModel.shared.triggerFlutterMethod(action: .logoutClick)
    }
}

///Callback from the flutter
extension DashboardViewModel{
    func onLogoutSuccess(data: [String: Any]){
        SVProgressHUD.dismiss()
        if let isLoggedOut = data["is_logout"] as? Bool{
            if isLoggedOut {
                delegate?.onLogoutSuccess()
            }else{
                let message: String = data["message"] as? String ?? ""
                delegate?.onFail(message: message)
            }
        }
    }
    
    func getDashboardDataResponse(data: [String: Any]){
        SVProgressHUD.dismiss()
        if let arrData = data["data"] as? [[String: Any]]{
            users = []
            
            for data in arrData {
                let id: Int = data["id"] as? Int ?? 0
                let name: String = data["name"] as? String ?? ""
                let email: String = data["email"] as? String  ?? ""
                let gender: String = data["gender"] as? String  ?? ""
                let status: String = data["status"] as? String  ?? ""
                
                let user = User.init(id: id, name: name, email: email, gender: gender, status: status)
                users.append(user)
            }
            delegate?.reload()
        }else{
            delegate?.onFail(message: "Unable to load data")
        }
    }
}
