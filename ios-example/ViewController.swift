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
    
    var access: Access?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        Access.setDebug(true)
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
        access = Access(key: "<your_app_id_here>")
    }
    
    private func setupAccessEvents() {
        access?.onLock {
            // content was locked
        }
        access?.onReady { _ in
            // paywall is ready
        }
        access?.onRelease { _ in
            // paywall was released
        }
    }
    
    private func createPaywall() {
        access?.createPaywall(pageType: "premium", view: contentView, percent: 90) {
            // Paywall was completed
        }
    }
}

