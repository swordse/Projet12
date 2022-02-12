//
//  HomeCollectionDataSource.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 27/12/2021.
//

import Foundation
import UIKit

class HomeCollectionDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var selectedSection: ((IndexPath) -> Void)?
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }
        if section == 1 {
            return 4
        }
        if section == 2 {
            return 3
        }
        else {
            return 0
        }
        
//        if section == 0 {
//            return News.topNews.count
//        }
//        if section == 1 {
//            return 1
//        }
//        if section == 2 {
//            return 4
//        }
//        if section == 3 {
//            return 1
//        }
//        else {
//            return 0
//        }
        
        
//        return section == 0 ? News.topNews.count : 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        if indexPath.section == 0 {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as! TitleCollectionViewCell
//            return cell
//        }
        
//        if indexPath.section == 0 {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionViewCell.identifier, for: indexPath) as! NewsCollectionViewCell
//            let new = News.topNews[indexPath.row]
//            cell.setCell(new: new)
//
//            return cell
//        }
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SectionHeaderCollectionViewCell.identifier, for: indexPath) as! SectionHeaderCollectionViewCell
            return cell
        }
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SectionCollectionViewCell.identifier, for: indexPath) as! SectionCollectionViewCell
            let category = Section.menuCategories[indexPath.row]
            cell.setCell(categorie: category)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SectionCollectionViewCell.identifier, for: indexPath) as! SectionCollectionViewCell
            // get the category for the map (range 5 in the array
            let category = Section.menuCategories[4]
            cell.setCell(categorie: category)
            return cell
        }
        
    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {

        return UICollectionViewCompositionalLayout { sectionIndex, environment in
            switch sectionIndex {
           
            case 0: return self.thirdLayoutSection()
            case 1: return self.forthLayoutSection()
            case 2: return self.fifhtLayoutSection()
            
            default: return self.thirdLayoutSection()
                
//            case 0: return self.secondLayoutSection()
//            case 1: return self.thirdLayoutSection()
//            case 2: return self.forthLayoutSection()
//            case 3: return self.fifhtLayoutSection()
//
//            default: return self.secondLayoutSection()
//            case 0: return self.firstLayoutSection()
//            case 1: return self.secondLayoutSection()
//            case 2: return self.thirdLayoutSection()
//            case 3: return self.forthLayoutSection()
//            default: return self.firstLayoutSection()
                
//            case 0: return self.firstLayoutSection()
//            case 1: return
//                self.secondLayoutSection()
//            default: return self.firstLayoutSection()
            }
        }
    }
    
//    func firstLayoutSection() -> NSCollectionLayoutSection {
//
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
//        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
//        itemLayout.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
//
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/10))
//        let groupLayout = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [itemLayout])
//        groupLayout.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
//
//        let section = NSCollectionLayoutSection(group: groupLayout)
//        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
//
//        return section
//    }
    
//    func secondLayoutSection() -> NSCollectionLayoutSection {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
//        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
//        itemLayout.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
//
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/1.1), heightDimension: .absolute(80))
////            .fractionalHeight(1/7)
//        let groupLayout = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [itemLayout])
//        groupLayout.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 10, bottom: 0, trailing: 10)
////        groupLayout.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
//
//        let section = NSCollectionLayoutSection(group: groupLayout)
//        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
//        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
//        return section
//    }
    
    func thirdLayoutSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
        itemLayout.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(70))
        let groupLayout = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [itemLayout])
        groupLayout.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: groupLayout)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
    
    func forthLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
                itemLayout.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 0, bottom: 10, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(145))
                let groupLayout = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: itemLayout, count: 2)
                groupLayout.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
        
                let section = NSCollectionLayoutSection(group: groupLayout)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
                return section
    }
    
    func fifhtLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
        itemLayout.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100))
        let groupLayout = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [itemLayout])
        groupLayout.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
//        groupLayout.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
        
        let section = NSCollectionLayoutSection(group: groupLayout)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        return section
    }
    
//    func firstLayoutSection() -> NSCollectionLayoutSection {
//
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
//        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
//        itemLayout.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
//
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/1.1), heightDimension: .fractionalHeight(1/5))
//        let groupLayout = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [itemLayout])
//        groupLayout.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
//
//        let section = NSCollectionLayoutSection(group: groupLayout)
//        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
//        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
//
//        return section
//    }
//
//    func secondLayoutSection() -> NSCollectionLayoutSection {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
//        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
//        itemLayout.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 1, bottom: 10, trailing: 1)
//
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/4))
//        let groupLayout = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: itemLayout, count: 2)
//        groupLayout.interItemSpacing = NSCollectionLayoutSpacing.fixed(10
//        )
//
//        let section = NSCollectionLayoutSection(group: groupLayout)
//        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
//        return section
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            return
        } else {
            selectedSection?(indexPath)
            print(indexPath)
        }
    }
}
