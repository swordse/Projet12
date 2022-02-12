//
//  QuizzViewController.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 27/12/2021.
//

import UIKit
//import FirebaseFirestore

class HomeQuizzViewController: UIViewController, StoryBoarded {

    var coordinator: QuizzCoordinator?
    var viewModel: HomeQuizzViewModel?
    
    var datasource = HomeQuizzDataSource()
    
//    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let activityIndicator: UIActivityIndicatorView = {
       let spin = UIActivityIndicatorView()
        spin.color = UIColor.systemGray
        spin.style = .large
        spin.contentMode = .scaleToFill
        spin.backgroundColor = UIColor.deepBlue
        return spin
    }()
    
    private let collectionview = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Quizz"
        view.addSubview(collectionview)
//        view.bringSubviewToFront(collectionview)
        collectionview.backgroundColor = .deepBlue
        collectionview.dataSource = datasource
        collectionview.delegate = datasource
    
        collectionview.frame = view.bounds
        collectionview.register(ThemeQuizzCollectionViewCell.nib(), forCellWithReuseIdentifier: ThemeQuizzCollectionViewCell.identifier)
        collectionview.register(CategoryQuizzCollectionViewCell.nib(), forCellWithReuseIdentifier: CategoryQuizzCollectionViewCell.identifier)
        collectionview.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: "header", withReuseIdentifier: HeaderCollectionReusableView.identifier)
        
        collectionview.collectionViewLayout = datasource.createCompositionalLayout()
        
        view.addSubview(activityIndicator)
        activityIndicator.frame = CGRect(x: view.center.x, y: view.center.x, width: 30, height: 30)
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        
        guard let viewModel = viewModel else {
            return
        }
        bind()
        viewModel.retrieveCategory()
    }
    
    func bind() {
        guard let viewModel = viewModel else {
            return
        }
        viewModel.theme = { [weak self] result  in
//            self?.activityIndicator.stopAnimating()
//            self?.activityIndicator.isHidden = false
            DispatchQueue.main.async {
                switch result {
                case.failure(let error):
                    switch error {
                    case.noData:
                        print("alert no data")
                        self?.alert()
                    case.errorOccured:
                        print("alert errorOccured")
                        self?.alert()
                    case.noConnection:
                        print("alert noConnection")
                        self?.alert()
                        self?.datasource.update(theme: nil)
                    }
                case.success(let success):
                    self?.datasource.update(theme: success)
                    self?.collectionview.reloadData()
                    self?.activityIndicator.isHidden = true
                    self?.activityIndicator.stopAnimating()
                }
                
//                self?.datasource.update(theme: theme)
//                self?.collectionview.reloadData()
            }
            print("THEME   \(result)")
        }
        viewModel.categories = { [weak self] categories in
            DispatchQueue.main.async {
                self?.datasource.update(categories: categories)
                self?.collectionview.reloadData()
            }
            print("CATEGORIE   \(categories)")
        }
        datasource.selectedTheme = viewModel.selectedTheme
    }


}
