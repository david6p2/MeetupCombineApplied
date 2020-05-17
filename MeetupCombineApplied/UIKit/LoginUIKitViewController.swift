//
//  LoginUIKitViewController.swift
//  MeetupCombineApplied
//
//  Created by David Andres Cespedes on 5/11/20.
//  Copyright © 2020 David Andres Cespedes. All rights reserved.
//

import UIKit
import Combine

class LoginUIKitViewController: UITableViewController {

    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordAgainTextField: UITextField!

    private var viewModel: LoginViewModel = .init()
    private var observer: NSObjectProtocol?

    deinit {
        NotificationCenter.default.removeObserver(observer!)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.reloadUI = { [weak self] emailMessage, passwordMessage, isButtonEnable in
            self?.tableView.beginUpdates()

            let emailfooter = self?.tableView.footerView(forSection: 0)
            emailfooter?.textLabel?.text = emailMessage
            emailfooter?.textLabel?.textColor = .red

            let passwordfooter = self?.tableView.footerView(forSection: 1)
            passwordfooter?.textLabel?.text = passwordMessage
            passwordfooter?.textLabel?.textColor = .red

            if self?.continueButton.isEnabled != isButtonEnable {
                self?.continueButton.isEnabled = isButtonEnable
            }

            self?.tableView.endUpdates()
        }

        self.observer = NotificationCenter.default.addObserver(
            forName: UITextField.textDidChangeNotification,
            object: nil,
            queue: nil
        ) { [weak self] (notification) in
            guard let textField = notification.object as? UITextField else { return }

            switch textField {
                case self?.emailTextField:
                    self?.viewModel.mail = self?.emailTextField.text ?? ""

                case self?.passwordTextField:
                    self?.viewModel.password = self?.passwordTextField.text ?? ""

                case self?.passwordAgainTextField:
                    self?.viewModel.passwordAgain = self?.passwordAgainTextField.text ?? ""

                default: break
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.reloadUI?("","",false)
    }
}
