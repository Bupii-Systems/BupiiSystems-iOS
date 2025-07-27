//
//  ProfileAndSettingsViewController.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 26/07/2025.
//

import UIKit
import FirebaseAuth

class ProfileAndSettingsViewController: UIViewController {
    
    private let profileView = ProfileAndSettingsUIKitView()
    private let viewModel: ProfileAndSettingsViewModel

    init(model: ProfileModel) {
        self.viewModel = ProfileAndSettingsViewModel(model: model)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        profileView.configure(
            name: viewModel.name,
            year: viewModel.year,
            attendance: viewModel.attendance,
            email: viewModel.email,
            plan: viewModel.plan,
            registrationType: viewModel.registrationType
        )
        view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brand

        profileView.onLogout = { [weak self] in
            self?.viewModel.logout()
        }

        viewModel.onLogout = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
    }
}
