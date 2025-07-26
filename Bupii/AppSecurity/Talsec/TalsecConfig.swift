//
//  TalsecConfig.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 26/06/2025.
//

import Foundation
import TalsecRuntime

class TalsecConfigure {
    
    static let sharedObjc = TalsecConfigure()
    
    private init() {}
    
        func initializeTalsec() {
        let config = TalsecConfig(
            appBundleIds: ["com.bupii.systems.Bupii"],
            appTeamId: "",
            watcherMailAddress: "pedroriibeiro.dev@gmail.com",
            isProd: true
        )
        Talsec.start(config: config)
    }
}

extension SecurityThreatCenter: SecurityThreatHandler {
    
    public func threatDetected(_ securityThreat: TalsecRuntime.SecurityThreat) {
        print("Security threat detected: \(securityThreat.rawValue)")
        
        switch securityThreat {
        case .jailbreak, .runtimeManipulation:
            showAlertAndCrash()
            
            
        case .signature, .debugger, .passcode, .passcodeChange, .simulator, .missingSecureEnclave, .deviceChange, .deviceID, .unofficialStore, .systemVPN, .screenshot, .screenRecording:
            handleThreat(securityThreat)
                        
        @unknown default:
            handleThreat(securityThreat)
        }
    }
    
    private func showAlertAndCrash() {
        guard let topController = UIApplication.shared.windows.first?.rootViewController else {
            fatalError("Jailbreak detected.")
        }
        
        let alertController = UIAlertController(
            title: "Security alert",
            message: "This device appears to be jailbroken, which may compromise your privacy and security. Please uninstall and reinstall the app to prevent potential issues.",
            
            preferredStyle: .alert
        )
        
        alertController.addAction(UIAlertAction(title: "Ok", style: .destructive) { _ in
            fatalError("Jailbreak detected. Crashing the app.")
        })
        
        topController.present(alertController, animated: true, completion: nil)
    }
    
    private func handleThreat(_ threat: TalsecRuntime.SecurityThreat) {
        
        switch threat {
            
        case .signature:
            print("App signature compromised. Restricting access.")
            
        case .debugger:
            print("Debugger detected. Disabling sensitive features.")
            
        case .runtimeManipulation:
            print("Runtime manipulation detected. Logging out user.")
            
        case .passcode:
            print("No passcode set on device. Alerting user.")
            
        case .passcodeChange:
            print("Passcode has changed. Re-authenticating user.")
            
        case .simulator:
            print("Running on simulator. Disabling sensitive features.")
            
        case .missingSecureEnclave:
            print("Missing Secure Enclave. Restricting access.")
            
        case .deviceChange:
            print("Device change detected. Re-authentication required.")
            
        case .deviceID:
            print("Device ID changed. Logging out user.")
            
        case .unofficialStore:
            print("Unofficial app installation. Disabling features.")
            
        case .systemVPN:
            print("System VPN detected. Warning user.")
            
        case .screenshot:
            print("System screenshot detected. Restricting access.")
            
        case .screenRecording:
            print("System screen recording detected. Restricting access.")
            
        default:
            print("Unknown threat detected. Logging incident.")
        }
    }
}
