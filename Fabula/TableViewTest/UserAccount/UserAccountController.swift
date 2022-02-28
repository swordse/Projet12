import Foundation
import UIKit

/// Protocol use to inform DetailAnecdoteTableViewController of the user's connexion status. UserAccount is the delegatee. Delegate is call on connexion and logout method. The delegate update dataSource to show the right UI.
protocol AuthentificationProtocol {
    func statusChange(isConnected: Bool)
}

final class UserAccountController: NSObject {
    
    var authentificationDelegate: AuthentificationProtocol?
    
    var userViewModel = UserAccountViewModel()
    
    struct Constants {
        static let backgroundAlphaTo: CGFloat = 1
    }
    
    private let backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .deepBlue
        backgroundView.alpha = 0
        return backgroundView
    }()
    
    private let alertView: UIView = {
        let alert = UIView()
        alert.backgroundColor = .white
        alert.layer.masksToBounds = true
        alert.layer.cornerRadius = 12
        return alert
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    private var titleLabel: UILabel = {
        let titleLabel = UILabel()
        return titleLabel
    }()
    
    private var messageLabel: UILabel = {
        return UILabel()
    }()
    
    private var userNameTextField: UITextField = {
        return UITextField()
    }()
    
    private var emailTextField: UITextField = {
        let emailTextField = UITextField()
        return emailTextField
    }()
    
    private var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        return passwordTextField
    }()
    
    private var confirmationPWTextField: UITextField = {
        let textfield = UITextField()
        return textfield
    }()
    
    private var connexionButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private var label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private var createButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private var toCreateButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private var toLoginButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private var logOutButton: UIButton = {
        return UIButton()
    }()
    
    private var myTargetView: UIView?
    
    func showUserConnexion(on navigationController: UINavigationController) {
        
        bind()
        
        guard let targetView = navigationController.view else {
            return
        }
        
        myTargetView = targetView
        
        userNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmationPWTextField.delegate = self
        
        backgroundView.frame = targetView.bounds
        targetView.addSubview(backgroundView)
        
        
        alertView.frame = CGRect(x: 10, y: targetView.frame.size.height, width: targetView.frame.size.width - 20, height: backgroundView.frame.size.height - 180)
        alertView.backgroundColor = UIColor(named: "darkBlue")
        
        targetView.addSubview(alertView)
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: alertView.frame.width, height: 40))
        titleLabel.text = "Connexion"
        titleLabel.textColor = .white
        titleLabel.backgroundColor = UIColor(named: "darkBlue")
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .center
        alertView.addSubview(titleLabel)
        
        let dismissButton = UIButton()
        let image = UIImage(systemName: "x.circle")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        dismissButton.setImage(image, for: .normal)
        dismissButton.addTarget(self, action: #selector(dismissViewConnexion), for: .touchUpInside)
        dismissButton.frame = CGRect(x: alertView.frame.size.width-30, y: 15, width: 20, height: 20)
        alertView.addSubview(dismissButton)
        
        NSLayoutConstraint.activate([
            dismissButton.widthAnchor.constraint(equalToConstant: 20),
            dismissButton.heightAnchor.constraint(equalToConstant: 20)])
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.contentMode = .scaleAspectFit
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        alertView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        messageLabel.backgroundColor = UIColor(named: "darkBlue")
        messageLabel.text = ""
        messageLabel.font = .systemFont(ofSize: 17)
        messageLabel.textColor = .white
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        
        userNameTextField.textColor = .black
        userNameTextField.attributedPlaceholder = NSAttributedString(
            string: "User Name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        userNameTextField.autocapitalizationType = .none
        userNameTextField.leftViewMode = .always
        userNameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        userNameTextField.backgroundColor = .white
        userNameTextField.layer.cornerRadius = 10
        userNameTextField.layer.borderWidth = 1
        userNameTextField.layer.borderColor = UIColor.black.cgColor
        
        emailTextField.textColor = .black
        emailTextField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        emailTextField.autocapitalizationType = .none
        emailTextField.leftViewMode = .always
        emailTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        emailTextField.backgroundColor = .white
        emailTextField.layer.cornerRadius = 10
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor.black.cgColor
        
        passwordTextField.textColor = .black
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "Mot de passe",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        passwordTextField.autocapitalizationType = .none
        passwordTextField.leftViewMode = .always
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        passwordTextField.isSecureTextEntry = true
        passwordTextField.backgroundColor = .white
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor.black.cgColor
        
        confirmationPWTextField.textColor = .black
        confirmationPWTextField.attributedPlaceholder = NSAttributedString(
            string: "Confirmez votre mot de passe",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        confirmationPWTextField.autocapitalizationType = .none
        confirmationPWTextField.leftViewMode = .always
        confirmationPWTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        confirmationPWTextField.isSecureTextEntry = true
        confirmationPWTextField.backgroundColor = .white
        confirmationPWTextField.layer.cornerRadius = 10
        confirmationPWTextField.layer.borderWidth = 1
        confirmationPWTextField.layer.borderColor = UIColor.black.cgColor
        
        connexionButton.layer.cornerRadius = 10
        connexionButton.layer.borderWidth = 1
        connexionButton.layer.borderColor = UIColor.black.cgColor
        connexionButton.setTitle("CONNEXION", for: .normal)
        connexionButton.titleLabel?.font = .boldSystemFont(ofSize: 17)
        connexionButton.setTitleColor(.white, for: .normal)
        connexionButton.backgroundColor = UIColor(named: "lightDark")
        connexionButton.addTarget(self, action: #selector(connexionTapped), for: .touchUpInside)
        
        createButton.layer.cornerRadius = 10
        createButton.layer.borderWidth = 1
        createButton.layer.borderColor = UIColor.black.cgColor
        createButton.setTitle("CREER UN COMPTE", for: .normal)
        createButton.titleLabel?.font = .boldSystemFont(ofSize: 17)
        createButton.setTitleColor(.white, for: .normal)
        createButton.backgroundColor = UIColor(named: "lightDark")
        
        createButton.addTarget(self, action: #selector(createTapped), for: .touchUpInside)
        
        label.textColor = .white
        label.backgroundColor = UIColor(named: "darkBlue")
        label.textAlignment = .center
        label.text = "OU"
        label.font = .boldSystemFont(ofSize: 17)
        
        toCreateButton.layer.cornerRadius = 10
        toCreateButton.layer.borderWidth = 1
        toCreateButton.layer.borderColor = UIColor.black.cgColor
        toCreateButton.setTitle("Créer un compte", for: .normal)
        toCreateButton.titleLabel?.font = .boldSystemFont(ofSize: 17)
        toCreateButton.setTitleColor(.white, for: .normal)
        toCreateButton.addTarget(self, action: #selector(toCreateTapped), for: .touchUpInside)
        toCreateButton.backgroundColor = UIColor(named: "lightDark")
        
        toLoginButton.layer.cornerRadius = 10
        toLoginButton.layer.borderWidth = 1
        toLoginButton.layer.borderColor = UIColor.black.cgColor
        toLoginButton.setTitle("Connexion", for: .normal)
        toLoginButton.titleLabel?.font = .boldSystemFont(ofSize: 17)
        toLoginButton.setTitleColor(.white, for: .normal)
        toLoginButton.backgroundColor = UIColor(named: "lightDark")
        toLoginButton.addTarget(self, action: #selector(toLoginTapped), for: .touchUpInside)
        
        logOutButton.layer.cornerRadius = 10
        logOutButton.layer.borderWidth = 1
        logOutButton.layer.borderColor = UIColor.black.cgColor
        logOutButton.setTitle("Se déconnecter", for: .normal)
        logOutButton.titleLabel?.font = .boldSystemFont(ofSize: 17)
        logOutButton.setTitleColor(.white, for: .normal)
        logOutButton.backgroundColor = UIColor(named: "lightDark")
        logOutButton.addTarget(self, action: #selector(logOutTapped), for: .touchUpInside)
        
        stackView.addArrangedSubview(messageLabel)
        stackView.addArrangedSubview(userNameTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(confirmationPWTextField)
        stackView.addArrangedSubview(connexionButton)
        stackView.addArrangedSubview(createButton)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(toCreateButton)
        stackView.addArrangedSubview(toLoginButton)
        stackView.addArrangedSubview(logOutButton)
        
        NSLayoutConstraint.activate([

            stackView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: +10),
            stackView.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -10),
            stackView.centerYAnchor.constraint(equalTo: alertView.centerYAnchor),
            userNameTextField.heightAnchor.constraint(equalToConstant: 40),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            confirmationPWTextField.heightAnchor.constraint(equalToConstant: 40),
            connexionButton.heightAnchor.constraint(equalToConstant: 40),
            label.heightAnchor.constraint(equalToConstant: 40),
            toCreateButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        confirmationPWTextField.isHidden = true
        toLoginButton.isHidden = true
        createButton.isHidden = true
        userNameTextField.isHidden = true
        
        if UserDefaultsManager().retrieveUserConnexion() {
            hideConnexion()
        } else {
            showConnexion()
        }
        
        UIView.animate(withDuration: 0.2, animations: {
            self.backgroundView.alpha = Constants.backgroundAlphaTo
        }, completion: { done in
            if done {
                UIView.animate(withDuration: 0.2, animations: {
                    self.alertView.center = targetView.center
                })
            }
        })
    }
    
    func bind() {
        // get info when user tapped SignInButton
        userViewModel.signInResult = {
            [weak self] result in
            switch result {
            case.failure(let networkError):
                self?.messageLabel.text = networkError.rawValue
                // set view
                self?.emailTextField.text?.removeAll()
                self?.passwordTextField.text?.removeAll()
                self?.emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
                self?.passwordTextField.attributedPlaceholder = NSAttributedString(string: "Mot de passe", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
                self?.emailTextField.becomeFirstResponder()
            case.success(_):
                self?.authentificationDelegate?.statusChange(isConnected: true)
                // set view
                self?.messageLabel.text = "Vous êtes connecté."
                self?.emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor : UIColor.placeholderText])
                self?.passwordTextField.attributedPlaceholder = NSAttributedString(string: "Mot de passe", attributes: [NSAttributedString.Key.foregroundColor : UIColor.placeholderText])
                self?.dismissView()
            }
        }
        
        userViewModel.accountCreationResult = {
            [weak self] result in
            
            switch result {
            case.failure(let networkError):
                switch networkError {
                case .invalidEmail:
                    self?.messageLabel.text = "L'email n'est pas valide."
                case .noConnection:
                    self?.messageLabel.text = "Vérifiez votre connexion internet."
                case .errorOccured:
                    self?.messageLabel.text = "Une erreur est survenue. Veuillez réessayer."
                case .emailAlreadyUsed:
                    self?.messageLabel.text = "Cet email est déjà utilisé."
                case .wrongPassWord:
                    self?.messageLabel.text = "Le mot de passe ne correspond pas à l'email."
                default:
                    self?.messageLabel.text = "Une erreur s'est produite. Veuillez réessayer."
                }
            case.success(_):
                self?.authentificationDelegate?.statusChange(isConnected: true)
                self?.messageLabel.isHidden = false
                self?.messageLabel.text = "Votre compte a été crée"
                self?.titleLabel.text = "Deconnexion"
                self?.hideConnexion()
                self?.logOutButton.isHidden = false
                self?.emailTextField.text?.removeAll()
                self?.passwordTextField.text?.removeAll()
                self?.confirmationPWTextField.text?.removeAll()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self?.dismissView()
                    self?.messageLabel.text = ""
                }
                
            }
    }
    }

    @objc
    func connexionTapped() {
        
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else { return }
        
        userViewModel.signIn(email: email, passWord: password)
    }

    // animation when creationButton is tapped (hide the connexion elements, show creation elements)
    @objc
    func toCreateTapped() {
        messageLabel.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
        confirmationPWTextField.text = ""
        userNameTextField.text = ""
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            self.userNameTextField.isHidden = false
            self.titleLabel.text = "Créer un compte"
            self.connexionButton.isHidden = true
            self.toCreateButton.isHidden = true
            self.label.isHidden = true
            self.emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
            self.passwordTextField.attributedPlaceholder = NSAttributedString(string: "Mot de passe", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
            
        }) { done in
            if done {
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
                    
                    self.confirmationPWTextField.isHidden = false
                    self.toLoginButton.isHidden = false
                    self.createButton.isHidden = false
                    self.label.isHidden = false
                }, completion: nil)
            }
        }
        
    }
    
    @objc
    func createTapped() {
        messageLabel.text = ""
        
        guard let userName = userNameTextField.text, !userName.isEmpty, let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty, let confirmationPassword = confirmationPWTextField.text, !confirmationPassword.isEmpty else { return }
        
        guard password == confirmationPassword else {
            messageLabel.text = "Erreur. Les mots de passe ne sont pas identiques."
            emailTextField.text?.removeAll()
            passwordTextField.text?.removeAll()
            confirmationPWTextField.text?.removeAll()
            emailTextField.becomeFirstResponder()
            return
        }
        
        guard password.count >= 6 else {
            messageLabel.text = "Le mot de passe doit au moins avoir 6 caractères."
            emailTextField.text?.removeAll()
            passwordTextField.text?.removeAll()
            confirmationPWTextField.text?.removeAll()
            emailTextField.becomeFirstResponder()
            return
        }
        // create account, save state, save user in userDefault, save user in firebase
        userViewModel.accountCreation(userEmail: email, password: password, userName: userName)
    }
        
    // animation when toCreateButton is tapped
    @objc
    func toLoginTapped() {
        messageLabel.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
        confirmationPWTextField.text = ""
        userNameTextField.text = ""
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            self.titleLabel.text = "Connexion"
            self.userNameTextField.isHidden = true
            self.createButton.isHidden = true
            self.confirmationPWTextField.isHidden = true
            self.toLoginButton.isHidden = true
            self.label.isHidden = true
        }) { done in
            if done {
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
                    self.connexionButton.isHidden = false
                    self.toCreateButton.isHidden = false
                    self.label.isHidden = false
                }, completion: nil)
            }
        }
    }
    
    @objc func logOutTapped() {
        messageLabel.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
        confirmationPWTextField.text = ""
        userNameTextField.text = ""
        userViewModel.logOut()
        // delegate to transmit connexion state to detail anecdote
        self.authentificationDelegate?.statusChange(isConnected: false)
        
        // reset the initial view
        showConnexion()
        
        dismissView()
        
    }
    
    @objc
    func dismissViewConnexion() {
        dismissView()
    }
    
    func dismissView() {
        guard let targetView = myTargetView else {return}
        UIView.animate(withDuration: 0.2, animations: {
            self.alertView.frame = CGRect(x: 40, y: targetView.frame.size.height, width: targetView.frame.size.width-80, height: 200)
        }, completion: { done in
            if done {
                UIView.animate(withDuration: 0.2) {
                    self.backgroundView.alpha = 0
                } completion: { done in
                    if done {
                        self.alertView.removeFromSuperview()
                        self.backgroundView.removeFromSuperview()
                    }
                }
            }
        })
    }
    
    func hideConnexion() {
        userNameTextField.isHidden = true
        logOutButton.isHidden = false
        emailTextField.isHidden = true
        passwordTextField.isHidden = true
        confirmationPWTextField.isHidden = true
        connexionButton.isHidden = true
        createButton.isHidden = true
        label.isHidden = true
        toCreateButton.isHidden = true
        toLoginButton.isHidden = true
    }
    
    func showConnexion() {
        logOutButton.isHidden = true
        emailTextField.isHidden = false
        passwordTextField.isHidden = false
        confirmationPWTextField.isHidden = true
        connexionButton.isHidden = false
        createButton.isHidden = true
        label.isHidden = false
        toCreateButton.isHidden = false
        toLoginButton.isHidden = true
    }
}

extension UserAccountController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userNameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        confirmationPWTextField.resignFirstResponder()
        return true
        
    }
}
