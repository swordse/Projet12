//
//  HomeQuizzDataSource.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 29/12/2021.
//

import Foundation
import UIKit

class HomeQuizzDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    // Categories and theme to display
    var categories = [QuizzCategoryInfo]()
    var theme: [[String]]?
    
    var previousIndex: IndexPath = [0, 0]
    
    // save the index of the theme
    var selectedCategoryIndex: Int?
    
    // closure to pass the selectedTheme to HomeQuizzViewController
    var selectedTheme: ((String) -> Void)?
    
    // update the theme
    func update(theme: [[String]]?) {
        self.theme = theme
    }
    // update category
    func update(categories: [QuizzCategoryInfo]) {
        self.categories = categories
    }
    
    //-MARK: CollectionView Data Source
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        if theme?.count ?? 0 > 0 {
        if section == 0 {
            return categories.count
        } else {
            print("SECTION: \(section)")
            if selectedCategoryIndex == nil {
                return theme?[0].count ?? 0
            } else {
                return theme?[selectedCategoryIndex!].count ?? 0
            }
        }
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryQuizzCollectionViewCell.identifier, for: indexPath) as! CategoryQuizzCollectionViewCell
            let category = categories[indexPath.row]
            cell.setCell(category: category)
            if indexPath == [0, 0] {
                cell.borderIsSet(true)
//                cell.categoryLabel.textColor = .white
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThemeQuizzCollectionViewCell.identifier, for: indexPath) as! ThemeQuizzCollectionViewCell
            
            if selectedCategoryIndex == nil {
                selectedCategoryIndex = 0
                let theme = theme?[selectedCategoryIndex!][indexPath.row]
                guard let theme = theme else {
                    return UICollectionViewCell()
                }
                cell.setCell(theme: theme)
                return cell
            } else {
                let theme = theme?[selectedCategoryIndex!][indexPath.row]
                guard let theme = theme else {
                    return UICollectionViewCell()
                }
                cell.setCell(theme: theme)
                return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("pathSelectedIndex \(collectionView.indexPathsForSelectedItems)")
//        if collectionView.indexPathsForSelectedItems == nil {
//            let cell = collectionView.cellForItem(at: indexPath)
//            
//            cell?.layer.borderWidth = 2
//            cell?.layer.borderColor = UIColor.red.cgColor
//        } else {
//            guard let lastSelectedIndex = collectionView.indexPathsForSelectedItems?.first else { return }
//            let cell = collectionView.cellForItem(at: lastSelectedIndex)
//            cell?.layer.borderWidth = 2
//        }
        
        
        if indexPath.section == 0 {
            print("PREVIOUS INDEX \(previousIndex)")
            print("INDEXPATH \(indexPath)")
            
            if indexPath == previousIndex {
                return
            }
            
            if indexPath != previousIndex {
                let previousCell = collectionView.cellForItem(at: previousIndex) as? CategoryQuizzCollectionViewCell
                previousCell?.borderIsSet(false)
//                previousCell?.categoryLabel.textColor = .black
            }
            
            let selectedCell = collectionView.cellForItem(at: indexPath)  as? CategoryQuizzCollectionViewCell
            selectedCell?.borderIsSet(true)
            selectedCell?.tiltImage()
//            selectedCell?.categoryLabel.textColor = .white
            previousIndex = indexPath
            
            if selectedCategoryIndex == indexPath.row {
                return
            }
        selectedCategoryIndex = indexPath.row
            collectionView.reloadSections(IndexSet(integer: 1))
            return
            
        } else {
            guard let selectedThemeIndex = selectedCategoryIndex else {
                return
            }
            guard let stringTheme = theme?[selectedThemeIndex][indexPath.row] else { return }
            selectedTheme?(stringTheme)
            print("STRINGTHEME DATASOURCE\(stringTheme)")
        }
    }
    

    // MARK: - CollectionView Layout
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, environment in
            switch sectionIndex {
            case 0:
                return self.firstLayoutSection()
            case 1: return self.secondLayoutSection()
            default: return self.firstLayoutSection()
            }
        }
    }
    
    func firstLayoutSection() -> NSCollectionLayoutSection {
        // Items
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        
        // Group
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .absolute(115)), subitems: [item])
        
        // Sections
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalHeight(1), heightDimension: .estimated(50))
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: "header", alignment: .top)
        section.boundarySupplementaryItems = [headerItem]
        return section
        
    }
    
    func secondLayoutSection() -> NSCollectionLayoutSection {
        // Items
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(70)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        
        // Group
        let group =    NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitems: [item])
        
        // Sections
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: "header", alignment: .top)
        section.boundarySupplementaryItems = [headerItem]
        
        return section
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: "header", withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as! HeaderCollectionReusableView
        var text = ""
        if indexPath.section == 0 {
            text = "Catégorie"
        } else {
            text = "Quizz"
        }
        header.configure(text: text)
        return header
    }
    
}
