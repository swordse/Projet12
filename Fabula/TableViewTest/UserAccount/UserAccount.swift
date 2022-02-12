import Foundation
import UIKit

/// Protocol use to inform DetailAnecdoteTableViewController of the user's connexion status. UserAccount is the delegatee. Delegate is call on connexion and logout method. The delegate update dataSource to show the right UI.
protocol AuthentificationProtocol {
    func statusChange(isConnected: Bool)
}
class UserAccount {
    
    var authentificationDelegate: AuthentificationProtocol?
    
    struct Constants {
        static let backgroundAlphaTo: CGFloat = 0.6
    }
    
    private let backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .black
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
        
        guard let targetView = navigationController.view else {
            return
        }
        
        myTargetView = targetView
        
        backgroundView.frame = targetView.bounds
        print("UIScreen BOUNDS: \(UIScreen.main.bounds)")
        print("TARGET VIEW CENTER: \(targetView.center)")
        print("TARGET VIEW BOUNS: \(targetView.bounds)")
        print("TARGET VIEW FRAME: \(targetView.frame)")
        targetView.addSubview(backgroundView)
        
        alertView.frame = CGRect(x: 10, y: targetView.frame.size.height, width: targetView.frame.size.width - 20, height: backgroundView.frame.size.height - 160)
        alertView.backgroundColor = UIColor(named: "darkBlue")
        print("ALERTVIEW FRAME AFTER SETUP: \(alertView.frame)")
        
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
        
        userNameTextField.placeholder = "User Name"
        userNameTextField.autocapitalizationType = .none
        userNameTextField.leftViewMode = .always
        userNameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        userNameTextField.backgroundColor = .white
        userNameTextField.layer.cornerRadius = 10
        userNameTextField.layer.borderWidth = 1
        userNameTextField.layer.borderColor = UIColor.black.cgColor
        
        emailTextField.placeholder = "Email"
        emailTextField.autocapitalizationType = .none
        emailTextField.leftViewMode = .always
        emailTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        emailTextField.backgroundColor = .white
        emailTextField.layer.cornerRadius = 10
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor.black.cgColor
        
        passwordTextField.placeholder = "Mot de passe"
        passwordTextField.autocapitalizationType = .none
        passwordTextField.leftViewMode = .always
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        passwordTextField.isSecureTextEntry = true
        passwordTextField.backgroundColor = .white
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor.black.cgColor
        
        confirmationPWTextField.placeholder = "Confirmer votre mot de passe"
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
        
        if UserDefaultManager.retrieveUserConnexion() {
            print("un utilisateur connecté")
            hideConnexion()
        } else {
            print("pas d'utilisateur")
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
    
    @objc func connexionTapped() {
        
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else { return }
        
        Fire.signIn(email: email, password: password) {
            [weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case.failure(let error):
                print(error)
                strongSelf.messageLabel.text = "Compte non reconnu. Veuillez réessayer."
                strongSelf.emailTextField.text?.removeAll()
                strongSelf.passwordTextField.text?.removeAll()
                strongSelf.emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
                strongSelf.passwordTextField.attributedPlaceholder = NSAttributedString(string: "Mot de passe", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
                strongSelf.emailTextField.becomeFirstResponder()
                return
            case.success(_):
                // connexion success
                // save userdefaults connexion state
                UserDefaultManager.userIsConnected(true)
                
                // delegate to inform detailAnecdote of the connexion state
                strongSelf.authentificationDelegate?.statusChange(isConnected: true)
                
                strongSelf.messageLabel.text = ""
                strongSelf.emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor : UIColor.placeholderText])
                strongSelf.passwordTextField.attributedPlaceholder = NSAttributedString(string: "Mot de passe", attributes: [NSAttributedString.Key.foregroundColor : UIColor.placeholderText])
                strongSelf.dismissView()
                print("Vous êtes connecté.")
                
                // retrieve userInfo in Firestore to store it in userdefault
                
                Fire.getUserInfo { user in
                    guard let user = user else {
                        return
                    }
                    UserDefaultManager.saveUser(userName: user.userName, userId: user.userId, userEmail: user.userEmail)
                }

            }
        }
        
        
//        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
//            guard let strongSelf = self else {
//                return
//            }
//            // connexion failed
//            guard error == nil else {
//                print("error connexion")
//                strongSelf.messageLabel.text = "Compte non reconnu. Veuillez réessayer."
//                strongSelf.emailTextField.text?.removeAll()
//                strongSelf.passwordTextField.text?.removeAll()
//                strongSelf.emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
//                strongSelf.passwordTextField.attributedPlaceholder = NSAttributedString(string: "Mot de passe", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
//                strongSelf.emailTextField.becomeFirstResponder()
//                return
//            }
//            // connexion success
//            // save userdefaults connexion state
//            UserDefaultManager.userIsConnected(true)
//
//            // delegate to inform detailAnecdote of the connexion state
//            strongSelf.authentificationDelegate?.statusChange(isConnected: true)
//
//            strongSelf.messageLabel.text = ""
//            strongSelf.emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor : UIColor.placeholderText])
//            strongSelf.passwordTextField.attributedPlaceholder = NSAttributedString(string: "Mot de passe", attributes: [NSAttributedString.Key.foregroundColor : UIColor.placeholderText])
//            strongSelf.dismissView()
//            print("Vous êtes connecté.")
//
//        }
//
//        // retrieve userInfo in Firestore to store it in userdefault
//
//        Fire.getUserInfo { user in
//            guard let user = user else {
//                return
//            }
//            UserDefaultManager.saveUser(userName: user.userName, userId: user.userId, userEmail: user.userEmail)
//        }
//        guard let userInfo = Fire.getUserInfo() else {
//            print("pas de userinfo dans UserAccount lors de la connexion ")
//            return
//        }
//        print("userinfo dans userccount lors de la connexion \(userInfo)")
//
//        UserDefaultManager.saveUser(userName: userInfo.userName, userId: userInfo.userId, userEmail: userInfo.userEmail)
        
    }
    // animation when creationButton is tapped (hide the connexion elements, show creation elements)
    @objc func toCreateTapped() {
        messageLabel.text = ""
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            self.userNameTextField.isHidden = false
            self.titleLabel.text = "Créer un compte"
            self.connexionButton.isHidden = true
            self.toCreateButton.isHidden = true
            self.label.isHidden = true
            self.emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor : UIColor.placeholderText])
            self.passwordTextField.attributedPlaceholder = NSAttributedString(string: "Mot de passe", attributes: [NSAttributedString.Key.foregroundColor : UIColor.placeholderText])
            
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
    
    @objc func createTapped() {
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
        Fire.createAccount(userEmail: email, password: password, userName: userName) { [weak self] result in
            
            switch result {
            case.failure(let error):
                print("an error occured")
                print("Error signing out: %@", error)
            case.success(_):
                guard let strongSelf = self else {
                    return
                }
                strongSelf.titleLabel.text = "Deconnexion"
                strongSelf.hideConnexion()
                strongSelf.logOutButton.isHidden = false
                strongSelf.emailTextField.text?.removeAll()
                strongSelf.passwordTextField.text?.removeAll()
                strongSelf.confirmationPWTextField.text?.removeAll()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    strongSelf.dismissView()
                }
            }
        }
    }
        
    // animation when toCreateButton is tapped
    @objc func toLoginTapped() {
        messageLabel.text = ""
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
        Fire.logOut()
//        do {
//            try Auth.auth().signOut()
//        } catch let signOutError as NSError {
//            print("Error signing out: %@", signOutError)
//        }
//        // userdefault save logout
//        UserDefaultManager.userIsConnected(false)
        
        // delegate to transmit connexion state to detail anecdote
        self.authentificationDelegate?.statusChange(isConnected: false)
        
        // reset the initial view
        showConnexion()
        
        dismissView()
        
    }
    
    @objc func dismissViewConnexion() {
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

