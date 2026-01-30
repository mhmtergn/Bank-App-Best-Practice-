//
//  ViewController.swift
//  Bank_App(Best Practice)
//
//  Created by Mehmet Ergun on 1/24/26.
//

import UIKit

protocol LoginViewControllerDelegate: AnyObject {
    func didLogin()
}

class LoginViewController: UIViewController {
    
    private let loginView = LoginView()
    private let signInButton = UIButton(type: .system)
    private let errorMessageLabel = UILabel()
    
    weak var delegate: LoginViewControllerDelegate?
    
    var username: String? {
        return loginView.usernameTextField.text
    }
    
    var password: String? {
        return loginView.passwordTextField.text
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
        
        view.backgroundColor = .systemBackground
        
    }
}

extension LoginViewController {
    private func style() {
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.layer.cornerRadius = 8
        signInButton.clipsToBounds = true
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .primaryActionTriggered)
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.isHidden = true
        
    }
    
    private func layout() {
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        
        // LOGIN VIEW
        NSLayoutConstraint.activate([
            loginView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1),
        ])
        
        //SIGN IN BUTTON
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            
        ])
        
        //ERROR MESSAGE
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 16),
            errorMessageLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            
        ])
        
    }
}

extension LoginViewController {
    @objc private func signInButtonTapped(sender: UIButton) {
        guard let username = username, let password = password else {
            assertionFailure("Username / password should never be nil")
            return
        }
        
       if username.isEmpty && password.isEmpty {
            errorMessageLabel.isHidden = false
            configureErrorMessage(withMessage: "Username / password cannot be blank" )
        }
        
        if username == "Jay" && password == "welcome" {
            errorMessageLabel.isHidden = true
            signInButton.configuration?.showsActivityIndicator = true
            delegate?.didLogin()
            
        } else {
            configureErrorMessage(withMessage: "Invalid username / password")
        }
    }
    
    func configureErrorMessage(withMessage: String) {
        errorMessageLabel.text = withMessage
        errorMessageLabel.isHidden = false
    }
}
