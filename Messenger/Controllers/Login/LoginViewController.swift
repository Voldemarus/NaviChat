//
//  LoginViewController.swift
//  Messenger
//
//  Created by admin on 29.04.2022.
//

import UIKit

class LoginViewController: UIViewController {

    // Скролл для хранения всех полей
    
    private let scrollView : UIScrollView  = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let emailField : UITextField = {
        let tf = UITextField().textEntry(aTitle: "Email address")
         return tf
    }()
    
    private let passwordField : UITextField = {
        let tf = UITextField().textEntry(aTitle: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    // картинка с логотипом
    private let imageView : UIImageView = {
        let imView  = UIImageView()
        imView.image = UIImage(named: "Logo")
        imView.contentMode = .scaleAspectFit
        return imView
    }()
    
    private let logButton: UIButton = {
        let b = UIButton().blueButton()
        b.addTarget(self, action: #selector(logButtonTapped), for: .touchUpInside)
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Loc("Log in")
        view.backgroundColor = .gray
        let regButton = UIBarButtonItem(title: Loc("Register"),
                style: .done,
                target: self,
                action: #selector(registerTapped))
        regButton.tintColor = UIColor.black
        navigationItem.rightBarButtonItem = regButton
        
        emailField.delegate = self
        passwordField.delegate = self
        
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(logButton)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        let size = scrollView.width/3
        imageView.frame = CGRect(x: (scrollView.width - size)/2,
                                 y: 30,
                                 width: size,
                                 height: size)
        emailField.frame = CGRect(x: 30,
                                  y: imageView.bottom + 20,
                                  width: scrollView.width - 60,
                                 height: 52)
        passwordField.frame = CGRect(x: 30,
                                  y: emailField.bottom + 20,
                                  width: scrollView.width - 60,
                                 height: 52)
        logButton.frame = CGRect(x: 50,
                                  y: passwordField.bottom + 20,
                                  width: scrollView.width - 100,
                                 height: 52)

    }
    
    
    @objc private func logButtonTapped() {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = emailField.text, let password = passwordField.text,
              !email.isEmpty, !password.isEmpty,
              password.count >= 6 else {
                userAlertError()
                return
        }
        // Log into Server
        
    }
    
    func userAlertError() {
        let alert = UIAlertController(title: Loc("Invalid login data"),
                 message: Loc("Review and enter proper login and password!"),
                preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Loc("Dismiss"), style: .cancel, handler: nil))
        present(alert, animated: true)
        
    }
    
    
    @objc private func registerTapped() {
        let rvc = RegisterViewController()
        rvc.title = Loc("Create New Account")
        navigationController?.pushViewController(rvc, animated: true)
        
        
    }

}

extension LoginViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            logButtonTapped()
        
        }
        return true
    }
}
