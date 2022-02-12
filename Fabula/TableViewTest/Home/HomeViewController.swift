//
//  HomeViewController.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 23/12/2021.
//

import UIKit

class HomeViewController: UIViewController, StoryBoarded {
    
    let userAccount = UserAccount()
    
    var coordinator: HomeCoordinator?
    
    var dataSource = HomeCollectionDataSource()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Fabula"
    
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "user"), style: .plain, target: self, action: #selector(connexionTapped))
        
        //        = UIBarButtonItem(image: UIImage(named: "person"), style: .plain, target: self, action: #selector(connexionTapped))
        //        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        view.addSubview(collectionView)
        view.backgroundColor = .deepBlue
//        collectionView.backgroundColor = .white
        collectionView.backgroundColor = .deepBlue
        collectionView.frame = CGRect(x: 10, y: 30, width: view.frame.size.width-20, height: view.frame.size.height-30)
        collectionView.register(TitleCollectionViewCell.nib(), forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        collectionView.register(NewsCollectionViewCell.nib(), forCellWithReuseIdentifier: NewsCollectionViewCell.identifier)
        collectionView.register(SectionHeaderCollectionViewCell.nib(), forCellWithReuseIdentifier: SectionHeaderCollectionViewCell.identifier)
        collectionView.register(SectionCollectionViewCell.nib(), forCellWithReuseIdentifier: SectionCollectionViewCell.identifier)
        
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
        
        collectionView.collectionViewLayout = dataSource.createCompositionalLayout()
        getSelectedIndex()
        
        // get the user connexion status
        Fire.getUserInfo { user in
            guard let user = user else {
                // user is not connected
                UserDefaultManager.userIsConnected(false)
                return
            }
            UserDefaultManager.userIsConnected(true)
            UserDefaultManager.saveUser(userName: user.userName, userId: user.userId, userEmail: user.userEmail)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if Core.shared.isNewUser() {
            // show welcome view
            let vc = storyboard?.instantiateViewController(withIdentifier: "welcome") as! WelcomeViewController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }
    
    // get the indexPath from datasource and navigate
    func getSelectedIndex() {
        dataSource.selectedSection = {
            [weak self] indexPath in
            if indexPath.section == 0 {
                return
            }
            if indexPath.section == 1 {
                switch indexPath.row {
                case 0:
                    self?.coordinator?.showAnecdotes()
                case 1:
                    self?.coordinator?.showQuote()
                case 2:
                    self?.coordinator?.showWord()
                case 3:
                    self?.coordinator?.showQuizz()
                default:
                    self?.coordinator?.showAnecdotes()
                }
            }
            if indexPath.section == 2 {
                switch indexPath.row {
                case 0:
                    self?.coordinator?.showMap()
                default:
                    return
                }
            }
        }
    }
    
    @objc func connexionTapped() {
        guard let navigationController = navigationController else {
            return
        }
        userAccount.showUserConnexion(on: navigationController)
    }
}


class Core {
    
    static let shared = Core()
    
    func isNewUser() -> Bool {
        return !UserDefaults.standard.bool(forKey: "isNewUser")
    }
    
    func setIsnotNewUser() {
        UserDefaults.standard.set(true, forKey: "isNewUser")
    }
    
}
