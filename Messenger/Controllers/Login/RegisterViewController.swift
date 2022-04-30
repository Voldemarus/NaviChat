//
//  RegisterViewController.swift
//  Messenger
//
//  Created by admin on 29.04.2022.
//

import UIKit

class RegisterViewController: UIViewController {

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
    
    private let firstNameField : UITextField = {
        let tf = UITextField().textEntry(aTitle: "First Name")
         return tf
    }()

    private let lastNameField : UITextField = {
        let tf = UITextField().textEntry(aTitle: "Last Name")
         return tf
    }()

    
    private let passwordField : UITextField = {
        let tf = UITextField().textEntry(aTitle: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let passwordField2 : UITextField = {
        let tf = UITextField().textEntry(aTitle: "Retype Password")
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
        let b = UIButton().greenButton("Register new account")
        b.addTarget(self, action: #selector(logButtonTapped), for: .touchUpInside)
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Loc("Register new account")
        view.backgroundColor = .white
        emailField.delegate = self
        passwordField.delegate = self
        
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(firstNameField)
        scrollView.addSubview(lastNameField)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(passwordField2)
        scrollView.addSubview(logButton)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(updateAvatar))
        imageView.addGestureRecognizer(gesture)
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        let size = scrollView.width/3
        imageView.frame = CGRect(x: (scrollView.width - size)/2,
                                 y: 30,
                                 width: size,
                                 height: size)
        firstNameField.frame = CGRect(x: 30,
                                  y: imageView.bottom + 20,
                                  width: scrollView.width - 60,
                                 height: 52)
        lastNameField.frame = CGRect(x: 30,
                                  y: firstNameField.bottom + 20,
                                  width: scrollView.width - 60,
                                 height: 52)
        emailField.frame = CGRect(x: 30,
                                  y: lastNameField.bottom + 20,
                                  width: scrollView.width - 60,
                                 height: 52)
        passwordField.frame = CGRect(x: 30,
                                  y: emailField.bottom + 20,
                                  width: scrollView.width - 60,
                                 height: 52)
        passwordField2.frame = CGRect(x: 30,
                                  y: passwordField.bottom + 20,
                                  width: scrollView.width - 60,
                                 height: 52)
        logButton.frame = CGRect(x: 50,
                                  y: passwordField2.bottom + 30,
                                  width: scrollView.width - 100,
                                 height: 52)

        // Tune ImageView look
        let l = imageView.layer
        l.cornerRadius = size / 2
        l.borderColor = UIColor.blue.cgColor
        l.masksToBounds = true
        l.borderWidth = 4.5
    }
    
    @objc private func updateAvatar() {
        
    }
    
    @objc private func logButtonTapped() {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        passwordField2.resignFirstResponder()
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        
        guard let email = emailField.text, let password = passwordField.text,
              let firstName = firstNameField.text,
              let lastName = lastNameField.text,
              let password2 = passwordField2.text,
              !email.isEmpty, !password.isEmpty,
              !firstName.isEmpty, !lastName.isEmpty,
              !password2.isEmpty,
              password.count >= 6 else {
                userAlertError()
                return
        }
        if password2 != password {
            invalidPasswordError()
            return
        }
        // Log into Server
        
    }
    
    func invalidPasswordError() {
        let alert = UIAlertController(title: Loc("Retype passwords!"),
                 message: Loc("Both copies of passwords should be identical!"),
                preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Loc("Dismiss"), style: .cancel, handler: nil))
        present(alert, animated: true)
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

extension RegisterViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstNameField {
            lastNameField.becomeFirstResponder()
        } else if textField == lastNameField {
            emailField.becomeFirstResponder()
        } else if textField == emailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            logButtonTapped()
        } else if textField == passwordField {
            passwordField2.becomeFirstResponder()
        }
        return true
    }
}
