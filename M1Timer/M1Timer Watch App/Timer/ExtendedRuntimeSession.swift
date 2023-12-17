//
//  ExtendedRuntimeSession.swift
//  M1Timer Watch App
//
//  Created by Nakajima on 2023/12/17.
//

import Foundation
import WatchKit

final class ExtendedRuntimeSession: NSObject, ObservableObject {
    private var session: WKExtendedRuntimeSession!
    var sessionEndCompletion: (() -> Void)?
    
    func startSession() {
        session = WKExtendedRuntimeSession()
        session.start()
    }
    
    func endSession() {
        session.invalidate()
    }
}

extension ExtendedRuntimeSession: WKExtendedRuntimeSessionDelegate {
    func extendedRuntimeSessionDidStart(_ extendedRuntimeSession: WKExtendedRuntimeSession) {}
    func extendedRuntimeSessionWillExpire(_ extendedRuntimeSession: WKExtendedRuntimeSession) {
        sessionEndCompletion?()
    }
        
    func extendedRuntimeSession(_ extendedRuntimeSession: WKExtendedRuntimeSession, didInvalidateWith reason: WKExtendedRuntimeSessionInvalidationReason, error: Error?) {
        sessionEndCompletion?()
    }
}
