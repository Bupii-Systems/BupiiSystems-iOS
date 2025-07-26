//
//  ProfileAndSettingsView.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 26/07/2025.
//

import UIKit

class ProfileAndSettingsUIKitView: UIView {
    
    // MARK: - Subviews
    
    private lazy var internalScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    private lazy var internalContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var backgroundRectangle: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hex: "#F4F4F4")
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var profileImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 12
        img.image = UIImage(named: "PersonProfilePicture")
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    private lazy var nameLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = .brand
        lb.font = UIFont.systemFont(ofSize: 20)
        return lb
    }()
    
    private lazy var secondaryRectangle: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var clientFromLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Cliente desde:"
        lb.textColor = .black
        lb.font = UIFont.systemFont(ofSize: 12)
        lb.textAlignment = .center
        return lb
    }()
    
    private lazy var yearLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = .brand
        lb.font = UIFont.systemFont(ofSize: 18)
        lb.textAlignment = .center
        return lb
    }()
    
    private lazy var dividerRectangle: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .brand
        return view
    }()
    
    private lazy var AttendancesLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Marcou presença:"
        lb.textColor = .black
        lb.font = UIFont.systemFont(ofSize: 12)
        lb.textAlignment = .center
        return lb
    }()
    
    private lazy var numberOfAttendancesLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = .brand
        lb.font = UIFont.systemFont(ofSize: 18)
        lb.textAlignment = .center
        return lb
    }()
    
    private lazy var emailTitleLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Email:"
        lb.textColor = .black
        lb.font = UIFont.boldSystemFont(ofSize: 18)
        lb.textAlignment = .center
        return lb
    }()
    
    private lazy var userEmailLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = .black
        lb.font = UIFont.systemFont(ofSize: 16)
        lb.textAlignment = .center
        return lb
    }()
    
    private lazy var planTypeLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Tipo de plano:"
        lb.textColor = .black
        lb.font = UIFont.boldSystemFont(ofSize: 18)
        lb.textAlignment = .center
        return lb
    }()
    
    private lazy var userPlanTypeLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = .brand
        lb.font = UIFont.systemFont(ofSize: 16)
        lb.textAlignment = .center
        return lb
    }()
    
    private lazy var registerTypeLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Tipo de registro:"
        lb.textColor = .black
        lb.font = UIFont.boldSystemFont(ofSize: 18)
        lb.textAlignment = .center
        return lb
    }()
    
    private lazy var userRegisterTypeLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = .brand
        lb.font = UIFont.systemFont(ofSize: 16)
        lb.textAlignment = .center
        return lb
    }()
    
    private lazy var footerTitleLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Agradecemos por você ser o nosso cliente!"
        lb.textColor = .brand
        lb.font = UIFont.boldSystemFont(ofSize: 18)
        lb.textAlignment = .center
        lb.numberOfLines = 0
        return lb
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Encerrar sessão", for: .normal)
        button.setTitleColor(.brand, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.brand.cgColor
        return button
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .brand
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    func configure(with model: ProfileModel) {
        nameLabel.text = model.name
        yearLabel.text = model.year
        numberOfAttendancesLabel.text = model.attendance
        userEmailLabel.text = model.email
        userPlanTypeLabel.text = model.plan
        userRegisterTypeLabel.text = model.registrationType
    }
    
    private func setupLayout() {
        addSubview(backgroundRectangle)
        backgroundRectangle.addSubview(internalScrollView)
        internalScrollView.addSubview(internalContentView)
        
        internalContentView.addSubview(profileImage)
        internalContentView.addSubview(nameLabel)
        internalContentView.addSubview(secondaryRectangle)
        internalContentView.addSubview(emailTitleLabel)
        internalContentView.addSubview(userEmailLabel)
        internalContentView.addSubview(logoutButton)
        
        secondaryRectangle.addSubview(clientFromLabel)
        secondaryRectangle.addSubview(yearLabel)
        secondaryRectangle.addSubview(dividerRectangle)
        secondaryRectangle.addSubview(AttendancesLabel)
        secondaryRectangle.addSubview(numberOfAttendancesLabel)
        secondaryRectangle.addSubview(planTypeLabel)
        secondaryRectangle.addSubview(userPlanTypeLabel)
        secondaryRectangle.addSubview(registerTypeLabel)
        secondaryRectangle.addSubview(userRegisterTypeLabel)
        secondaryRectangle.addSubview(footerTitleLabel)
        
        NSLayoutConstraint.activate([
            
            backgroundRectangle.topAnchor.constraint(equalTo: topAnchor, constant: 89),
            backgroundRectangle.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundRectangle.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundRectangle.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            internalScrollView.topAnchor.constraint(equalTo: backgroundRectangle.topAnchor),
            internalScrollView.leadingAnchor.constraint(equalTo: backgroundRectangle.leadingAnchor),
            internalScrollView.trailingAnchor.constraint(equalTo: backgroundRectangle.trailingAnchor),
            internalScrollView.bottomAnchor.constraint(equalTo: backgroundRectangle.bottomAnchor, constant: -126),
            
            internalContentView.topAnchor.constraint(equalTo: internalScrollView.topAnchor),
            internalContentView.leadingAnchor.constraint(equalTo: internalScrollView.leadingAnchor),
            internalContentView.trailingAnchor.constraint(equalTo: internalScrollView.trailingAnchor),
            internalContentView.bottomAnchor.constraint(equalTo: internalScrollView.bottomAnchor),
            internalContentView.widthAnchor.constraint(equalTo: internalScrollView.widthAnchor),
            
            profileImage.topAnchor.constraint(equalTo: internalContentView.topAnchor, constant: -8),
            profileImage.leadingAnchor.constraint(equalTo: internalContentView.leadingAnchor),
            profileImage.trailingAnchor.constraint(equalTo: internalContentView.trailingAnchor),
            profileImage.heightAnchor.constraint(equalToConstant: 287),
            
            nameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 27),
            nameLabel.centerXAnchor.constraint(equalTo: internalContentView.centerXAnchor),
            
            secondaryRectangle.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 19),
            secondaryRectangle.leadingAnchor.constraint(equalTo: internalContentView.leadingAnchor, constant: 18),
            secondaryRectangle.trailingAnchor.constraint(equalTo: internalContentView.trailingAnchor, constant: -17),
            secondaryRectangle.heightAnchor.constraint(equalToConstant: 67),
            
            clientFromLabel.topAnchor.constraint(equalTo: secondaryRectangle.topAnchor, constant: 12),
            clientFromLabel.leadingAnchor.constraint(equalTo: secondaryRectangle.leadingAnchor, constant: 36),
            
            yearLabel.topAnchor.constraint(equalTo: clientFromLabel.bottomAnchor, constant: 4),
            yearLabel.leadingAnchor.constraint(equalTo: clientFromLabel.leadingAnchor, constant: 18),
            
            dividerRectangle.topAnchor.constraint(equalTo: secondaryRectangle.topAnchor, constant: 12),
            dividerRectangle.centerXAnchor.constraint(equalTo: internalContentView.centerXAnchor),
            dividerRectangle.bottomAnchor.constraint(equalTo: secondaryRectangle.bottomAnchor, constant: -12),
            dividerRectangle.widthAnchor.constraint(equalToConstant: 1),
            
            AttendancesLabel.topAnchor.constraint(equalTo: clientFromLabel.topAnchor),
            AttendancesLabel.trailingAnchor.constraint(equalTo: secondaryRectangle.trailingAnchor, constant: -36),
            
            numberOfAttendancesLabel.topAnchor.constraint(equalTo: yearLabel.topAnchor),
            numberOfAttendancesLabel.trailingAnchor.constraint(equalTo: AttendancesLabel.trailingAnchor, constant: -18),
            
            emailTitleLabel.topAnchor.constraint(equalTo: secondaryRectangle.bottomAnchor, constant: 24),
            emailTitleLabel.leadingAnchor.constraint(equalTo: secondaryRectangle.leadingAnchor, constant: 18),
            
            userEmailLabel.topAnchor.constraint(equalTo: emailTitleLabel.bottomAnchor, constant: 8),
            userEmailLabel.leadingAnchor.constraint(equalTo: secondaryRectangle.leadingAnchor, constant: 18),
            //            footerTitleLabel.bottomAnchor.constraint(equalTo: internalContentView.bottomAnchor, constant: -32),
            
            planTypeLabel.topAnchor.constraint(equalTo: userEmailLabel.bottomAnchor,constant: 24),
            planTypeLabel.leadingAnchor.constraint(equalTo: userEmailLabel.leadingAnchor),
            
            userPlanTypeLabel.topAnchor.constraint(equalTo: planTypeLabel.bottomAnchor, constant: 8),
            userPlanTypeLabel.leadingAnchor.constraint(equalTo: planTypeLabel.leadingAnchor),
            
            registerTypeLabel.topAnchor.constraint(equalTo: userPlanTypeLabel.bottomAnchor, constant: 24),
            registerTypeLabel.leadingAnchor.constraint(equalTo: userPlanTypeLabel.leadingAnchor),
            
            userRegisterTypeLabel.topAnchor.constraint(equalTo: registerTypeLabel.bottomAnchor, constant: 8),
            userRegisterTypeLabel.leadingAnchor.constraint(equalTo: registerTypeLabel.leadingAnchor),
            
            footerTitleLabel.topAnchor.constraint(equalTo: userRegisterTypeLabel.bottomAnchor, constant: 47),
            footerTitleLabel.leadingAnchor.constraint(equalTo: backgroundRectangle.leadingAnchor, constant: 12),
            footerTitleLabel.trailingAnchor.constraint(equalTo: backgroundRectangle.trailingAnchor, constant: -12),
            
            logoutButton.topAnchor.constraint(equalTo: footerTitleLabel.bottomAnchor, constant: 24),
            logoutButton.centerXAnchor.constraint(equalTo: internalContentView.centerXAnchor),
            logoutButton.leadingAnchor.constraint(equalTo: backgroundRectangle.leadingAnchor, constant: 18),
            logoutButton.trailingAnchor.constraint(equalTo: backgroundRectangle.trailingAnchor, constant: -18),
            logoutButton.heightAnchor.constraint(equalToConstant: 56),
            logoutButton.bottomAnchor.constraint(equalTo: internalContentView.bottomAnchor, constant: -32)
            
        ])
    }
}

//MARK: - Sugestion (less code)

//private func makeLabel(text: String, font: UIFont, color: UIColor, alignment: NSTextAlignment = .center) -> UILabel {
//    let label = UILabel()
//    label.translatesAutoresizingMaskIntoConstraints = false
//    label.text = text
//    label.font = font
//    label.textColor = color
//    label.textAlignment = alignment
//    return label
//}
