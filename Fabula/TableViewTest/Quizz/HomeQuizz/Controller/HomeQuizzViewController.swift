//
//  QuizzViewController.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 27/12/2021.
//
import UIKit

final class HomeQuizzViewController: UIViewController, StoryBoarded {
    
    var coordinator: QuizzCoordinator?
    var viewModel: HomeQuizzViewModel?
    var datasource = HomeQuizzDataSource()
    
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
        // set up view
        title = "Quizz"
        view.addSubview(collectionview)
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
        // set up data
        guard let viewModel = viewModel else {
            return
        }
        bind()
        viewModel.retrieveCategory()
    }
    // bind with view model
    func bind() {
        guard let viewModel = viewModel else {
            return
        }
        viewModel.theme = { [weak self] result  in
            DispatchQueue.main.async {
                switch result {
                case.failure(let error):
                    switch error {
                    case.noData:
                        self?.alert(networkError: error)
                    case.errorOccured:
                        self?.alert(networkError: error)
                    case.noConnection:
                        self?.alert(networkError: error)
                        self?.datasource.update(theme: nil)
                    default:
                        self?.alert(networkError: .errorOccured)
                    }
                case.success(let success):
                    self?.datasource.update(theme: success)
                    self?.collectionview.reloadData()
                    self?.activityIndicator.isHidden = true
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
        viewModel.categories = { [weak self] categories in
            DispatchQueue.main.async {
                self?.datasource.update(categories: categories)
                self?.collectionview.reloadData()
            }
        }
        datasource.selectedTheme = viewModel.selectedTheme
    }
}
