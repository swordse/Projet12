//
//  WelcomeViewController.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 05/02/2022.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var holderView: UIView!
    
    let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            configure()
        }
    
    private func configure() {
        // set up scrollView
        
        scrollView.frame = holderView.bounds
        holderView.addSubview(scrollView)
        
        let titles = ["Apprenez tous les jours", "Testez vos connaissances", "Apprenez en vous promenant"]
        
        let imageNames = ["BookOB", "GameOB", "MapOB"]
        
        let descriptionText = ["Tous les jours de nouvelles anecdotes, des citations et un nouveau mot", "Avec des quizz originaux", "En activant la géolocalisation"]
        
        for x in 0..<3 {
            let pageView = UIView(frame: CGRect(x: CGFloat(x) * holderView.frame.size.width, y: 0, width: holderView.frame.size.width, height: holderView.frame.size.height))
            pageView.backgroundColor = .deepBlue
            scrollView.addSubview(pageView)

            
            let nextButton = UIButton(frame: CGRect(x: 10, y: pageView.frame.size.height - 100, width: pageView.frame.size.width-20, height: 50))
//            let nextButton = UIButton()
            
            let imageView = UIImageView(frame: CGRect(x: 50, y: 200, width: pageView.frame.size.width-100, height: 100))
//            let imageView = UIImageView()
            
            let titleLabel = UILabel(frame: CGRect(x: 10, y: pageView.frame.size.height - 280, width: pageView.frame.size.width-20, height: 50))
//            let titleLabel = UILabel()
            
            let descriptionLabel = UILabel(frame: CGRect(x: 10, y: pageView.frame.size.height - 200, width: pageView.frame.size.width-20, height: 60))
//            let descriptionLabel = UILabel()
            
            titleLabel.textAlignment = .center
            titleLabel.font = .systemFont(ofSize: 24, weight: .semibold)
            titleLabel.textColor = .label
            titleLabel.text = titles[x]
            pageView.addSubview(titleLabel)
            
            descriptionLabel.textAlignment = .center
            descriptionLabel.font = .systemFont(ofSize: 18, weight: .regular)
            descriptionLabel.numberOfLines = 0
            descriptionLabel.textColor = .label
            descriptionLabel.text = descriptionText[x]
            pageView.addSubview(descriptionLabel)
            
            nextButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
            nextButton.setTitleColor(.label, for: .normal)
            nextButton.setTitle("Continue", for: .normal)
            nextButton.tag = x+1
            nextButton.backgroundColor = UIColor(named: "purple")
            nextButton.layer.cornerRadius = 15
            if x == 2 {
                nextButton.setTitle("Terminé", for: .normal)
            }
            pageView.addSubview(nextButton)
            
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(named: imageNames[x])
            pageView.addSubview(imageView)
                
        }
        scrollView.contentSize = CGSize(width: holderView.frame.size.width * 3, height: 0)
        scrollView.isPagingEnabled = true
    }
    
    @objc func didTapButton (_ button: UIButton) {
        guard button.tag < 3 else {
            Core.shared.setIsnotNewUser()
            dismiss(animated: true, completion: nil)
            return
        }
        scrollView.setContentOffset(CGPoint(x: holderView.frame.size.width * CGFloat(button.tag), y: 0), animated: true)
    }

}


