//
//  DashboardVC.swift
//  HybridFlutterNative
//
//  Created by Hitesh Surani on 19/01/23.
//

import Foundation
import UIKit
import SVProgressHUD

class DashboardVC: BaseViewController {
    
    @IBOutlet weak var tblUser : UITableView!
    
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    ///Init data
    private func setup(){
        DashboardSetup.setUp(binaryMessenger: flutterEngine.binaryMessenger, api: self)
        
        tblUser.delegate = self
        tblUser.dataSource = self
        tblUser.tableFooterView = UIView()
        tblUser.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        SVProgressHUD.show()
        AppViewModel.shared.triggerFlutterMethod(action: .getDashboardData)
    }
}

//MARK: Actions
extension DashboardVC{
    @IBAction func btnLogoutClick(){
        SVProgressHUD.show()
        AppViewModel.shared.triggerFlutterMethod(action: .logoutClick)
    }
    
    @IBAction func btnStartTimerClick(){
        Router.navigateToCounterScreen()
    }
}

//MARK: DashboardDelegate - Callback from the flutter
extension DashboardVC: Dashboard {
    func onUserFetch(users: [User]?, message: String) throws {
        SVProgressHUD.dismiss()
        self.users = users ?? []
        reload()
    }
    
    func onLogout(isLogout: Bool, message: String) throws {
        Router.navigateToLogin()        
    }
    
    func reload() {
        tblUser.reloadData()
    }
}

//MARK: UITableView Delegate & Datasource
extension DashboardVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let user =  users[indexPath.row]

        cell.textLabel?.text = "User Name: \(user.name ?? "")"
        cell.detailTextLabel?.text = "Email: \(user.email ?? "")"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}

