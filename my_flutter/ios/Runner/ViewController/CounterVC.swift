//
//  CounterVc.swift
//  HybridFlutterNative
//
//  Created by Hitesh Surani on 27/01/23.
//

import UIKit

class CounterVC: BaseViewController {
    @IBOutlet weak var lblCounter : UILabel!
    @IBOutlet weak var lblStatus : UILabel!
    @IBOutlet weak var btnStartTimer : UIButton!
    
    lazy var viewModel = CounterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.removeObserver()
    }
    
    //Init data
    private func setup(){
        viewModel.delegate = self
        reload()
    }
}

//Mark:- Actions
extension CounterVC {
    @IBAction func onCounterStartClick(){
        viewModel.onTimerStartClick()
    }
}


//Mark:- Counter delegates
extension CounterVC: CounterDelegate {
    func reload() {
        if viewModel.state.lowercased() == "completed" {
            btnStartTimer.setTitle("Restart", for: .normal)
        }else if viewModel.state.lowercased() == "running" {
            btnStartTimer.setTitle("Pause", for: .normal)
        }else if viewModel.state.lowercased() == "pause" {
            btnStartTimer.setTitle("Resume", for: .normal)
        }else if viewModel.state.lowercased() == "notstarted" {
            btnStartTimer.setTitle("Start Timer", for: .normal)
        }
        lblStatus.text = "COUNTER IS \(viewModel.state)"
        lblCounter.text = "\(viewModel.timerValue)"
    }
}
