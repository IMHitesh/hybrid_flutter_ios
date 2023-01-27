//
//  File.swift
//
//
//  Created by Hitesh Surani on 16/01/23.
//

import Foundation
import SVProgressHUD


protocol CounterDelegate: BaseViewModelDelegate {
    
}

class CounterViewModel: BaseViewModel{
    
    var delegate: CounterDelegate?    
    var state: String = ""
    var timerValue: Int = 0
    
    override init() {
        super.init()
        addObserver()
        AppViewModel.shared.triggerFlutterMethod(action: .countDownInit)
    }
    
    deinit {
        removeObserver()
    }
}

extension CounterViewModel {
    func onTimerStartClick(){
        AppViewModel.shared.triggerFlutterMethod(action: .timerPauseOrChangeOrPause)
    }
}

///Callback from the flutter
extension CounterViewModel{
    func onTimerStartOrChangeResponse(data: [String: Any]){
        if let seconds = data["seconds"] as? Int,
           let state = data["state"] as? String{
            self.timerValue = seconds
            self.state = state.uppercased()
            delegate?.reload()
        }
    }
}
