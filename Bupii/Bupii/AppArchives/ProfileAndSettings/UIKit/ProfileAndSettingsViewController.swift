//
//  ProfileAndSettingsViewController.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 26/07/2025.
//

import UIKit
import FirebaseAuth

class ProfileAndSettingsViewController: UIViewController {
    
    private let profileAndSettingsView: ProfileAndSettingsUIKitView = ProfileAndSettingsUIKitView()
    private let model: ProfileModel
    
    init(model: ProfileModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        profileAndSettingsView.configure(with: model)
        view = profileAndSettingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brand
    }
    
}


