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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    //Init data
    private func setup(){
        CounterSetup.setUp(binaryMessenger: flutterEngine.binaryMessenger, api: self)
        AppViewModel.shared.triggerFlutterMethod(action: .countDownInit)
    }
}

//Mark:- Actions
extension CounterVC {
    @IBAction func onCounterStartClick(){
        AppViewModel.shared.triggerFlutterMethod(action: .timerPauseOrChangeOrPause)        
    }
}


//Mark:- Counter delegates
extension CounterVC: Counter {
    func onTimerStartOrChange(state: String, duration: Int32) throws {
        if state.lowercased() == "completed" {
            btnStartTimer.setTitle("Restart", for: .normal)
        }else if state.lowercased() == "running" {
            btnStartTimer.setTitle("Pause", for: .normal)
        }else if state.lowercased() == "pause" {
            btnStartTimer.setTitle("Resume", for: .normal)
        }else if state.lowercased() == "notstarted" {
            btnStartTimer.setTitle("Start Timer", for: .normal)
        }
        lblStatus.text = "COUNTER IS \(state.uppercased())"
        lblCounter.text = "\(duration)"
    }
}
