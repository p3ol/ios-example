//
//  ViewController.swift
//  ios-example
//
//  Created by Morgan Berger on 13/11/2023.
//

import UIKit
import AccessIOS
import AppTrackingTransparency

// Set your APP ID here
let APP_ID: String = "<your_app_id_here>"


class ViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var loremLabel: UILabel!
    
    var access: Access?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        Access.setDebug(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { _ in
                DispatchQueue.main.async { [weak self] in
                    self?.setup()
                }
            }
        } else {
            setup()
        }
    }
    
    private func setup() {
        access = Access(key: APP_ID)
        
        setupAccessConfig()
        setupAccessEvents()
        
        createPaywall()
    }
    
    private func setupAccessConfig() {
//        access?.config([
//           "app_name" : "My custom app name",
//           "locale" : "en",
//           "alternative_widget" : "gift",
//           "login_button_enabled" : false,
//           "login_url" : "https://google.com",
//           "subscription_url": "https://youtube.com",
//        ])
//        access?.config(["context": ["custom-context"]])
    }
    
    private func setupAccessEvents() {
        access?.onLock {
            print("content locked")
        }
        access?.onReady { _ in
            print("paywall ready")
        }
        access?.onPaywallSeen { _ in
            print("paywall seen")
        }
        access?.onRelease { _ in
            print("paywall released")
        }

        access?.onError { event, _ in
            guard let event = event else { return }
            print("Access SDK encountered an unexpected error:")
            print(event.error)
        }
    }
    
    private func createPaywall() {
        access?.createPaywall(pageType: "premium", view: contentView, percent: 90)
    }
}

