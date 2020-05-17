import Foundation

final class LoginViewModel {
    var mail: String = "" {
        didSet {
            updateUI()
        }
    }
    var password: String = "" {
        didSet {
            updateUI()
        }
    }
    var passwordAgain: String = "" {
        didSet {
            updateUI()
        }
    }

    var mailMessage: String = "Your mail should be longer than 3 characters"
    var passwordMessage: String = "Validate your passwords are equal and contains at leats 6 characters"
    var enabledContinue: Bool = false

    var reloadUI: ((String, String, Bool) -> Void)?

    func updateUI() {
        mailMessage = isValidUserName ? "" : "Your mail should be longer than 3 characters"
        passwordMessage = isPasswordValid ? "" : "Validate your passwords are equal and contains at leats 6 characters"
        enabledContinue = isLoginInfoValid
        reloadUI?(mailMessage, passwordMessage, enabledContinue)
    }

    var isValidUserName: Bool {
        mail.count > 3
    }

    var isPasswordNotEmpty: Bool {
        !password.isEmpty
    }

    var arePasswordEqual: Bool {
        password == passwordAgain
    }

    var isPasswordStrong: Bool {
        password.count >= 6
    }

    var isPasswordValid: Bool {
        isPasswordNotEmpty && arePasswordEqual && isPasswordStrong
    }

    var isLoginInfoValid: Bool {
        isValidUserName && isPasswordValid
    }
}
