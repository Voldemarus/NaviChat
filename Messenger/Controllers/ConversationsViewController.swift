//
//  ViewController.swift
//  Messenger
//
//  Created by admin on 29.04.2022.
//

import UIKit

class ConversationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }

    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        let logged = UserDefaults.standard.bool(forKey: "logged")
        if !logged {
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
            
        }
    }

}

