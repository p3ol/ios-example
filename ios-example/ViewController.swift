//
//  ViewController.swift
//  ios-example
//
//  Created by Morgan Berger on 13/11/2023.
//

import UIKit
import AccessIOS
import AppTrackingTransparency

class ViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var loremLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Access.config(["debug": true])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { [weak self] _ in
                self?.setup()
            }
        } else {
            setup()
        }
    }
    
    private func setup() {
        instanciateAccess()
        setupAccessEvents()
        createPaywall()
    }
    
    private func instanciateAccess() {
        try? Access.instanciate(key: "<your_app_id_here>")
    }
    
    private func setupAccessEvents() {
        Access.onLock {
            // content was locked
        }
        Access.onReady { _ in
            // paywall is ready
        }
        Access.onRelease { _ in
            // paywall was released
        }
    }
    
    private func createPaywall() {
        Access.createPaywall(pageType: "premium", view: contentView, percent: 90) {
            // Paywall was completed
        }
    }
}

