//
//  DashboardVC.swift
//  HybridFlutterNative
//
//  Created by Hitesh Surani on 19/01/23.
//

import Foundation
import UIKit

class DashboardVC: BaseViewController {
    
    @IBOutlet weak var tblUser : UITableView!
    
    lazy var viewModel = DashboardViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    ///Init data
    private func setup(){
        viewModel.delegate = self
        tblUser.delegate = self
        tblUser.dataSource = self
        tblUser.tableFooterView = UIView()
        tblUser.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        viewModel.getDashboardData()
    }
}

//MARK: Actions
extension DashboardVC{
    @IBAction func btnLogoutClick(){
        viewModel.onLogoutClick()
    }
    
    @IBAction func btnStartTimerClick(){
        Router.navigateToCounterScreen()
    }
}

//MARK: DashboardDelegate - Callback from the flutter
extension DashboardVC: DashboardDelegate {
    func onLogoutSuccess() {
        Router.navigateToLogin()
        viewModel.removeObserver()
    }
    
    func reload() {
        tblUser.reloadData()
    }
}

//MARK: UITableView Delegate & Datasource
extension DashboardVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let user =  viewModel.users[indexPath.row]

        cell.textLabel?.text = "User Name: \(user.name ?? "")"
        cell.detailTextLabel?.text = "Email: \(user.email ?? "")"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}

