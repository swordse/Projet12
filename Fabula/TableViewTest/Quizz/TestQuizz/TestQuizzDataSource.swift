//
//  TestQuizzDataSource.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 04/01/2022.
//

import Foundation
import UIKit

class TestQuizzDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var propositions = [String]()
    
    var playerResponse: ((String) -> Void)?
    var animationIsFinished: ((Bool) -> Void)?
    
    var isCorrect: Bool?
    var isOngoing: Bool?
    var cell: TestQuizzTableViewCell?
    var selectedIndex: IndexPath?
    
    func updatePropositions(propositions: [String]) {
        self.propositions = propositions
    }
    
    func updateIsCorrect(isCorrect: Bool) {
        self.isCorrect = isCorrect
    }
    
    func updateIsOngoing(isOngoing: Bool) {
        self.isOngoing = isOngoing
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        propositions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TestQuizzTableViewCell.identifier, for: indexPath) as! TestQuizzTableViewCell
        let proposition = propositions[indexPath.row]
        cell.setCell(proposition: proposition)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.isUserInteractionEnabled = false
        selectedIndex = indexPath
        
        print("INDEXPATHROW SELECTED: \(indexPath)")
        // get the response and pass it in the closure for viewcontroller
        let response = propositions[indexPath.row]
        playerResponse?(response)
        
        guard let isCorrect = isCorrect else {
            return
        }
        
        if selectedIndex != nil {
            
            cell = tableView.cellForRow(at: selectedIndex!) as? TestQuizzTableViewCell
            
            // if selected cell is correct
            if isCorrect && selectedIndex == indexPath {
                cell?.backView.backgroundColor = UIColor(named: "green")
                //                        cell?.propositionLabel.backgroundColor = .green
            }
            else if isCorrect && selectedIndex != indexPath {
                cell?.backView.backgroundColor = UIColor(named: "red")
                //                    cell?.propositionLabel.backgroundColor = .red
            }
            //     if selected cell is incorrect
            if !isCorrect && selectedIndex == indexPath {
                cell?.backView.backgroundColor = UIColor(named: "red")
                //                    cell?.propositionLabel.backgroundColor = .red
            }
        }
        
        
        guard let isOngoing = isOngoing else {
            return
        }
        
        if isOngoing {
            tableView.translateLeftAnim { _ in
                // informer viewcontroller que l'animation est finie et que les data peuvent être rechargées.
                self.animationIsFinished?(true)
                tableView.setBackAnim(completion: nil)
                self.cell?.backView.backgroundColor = .lightBlue
                //                self.cell?.propositionLabel.backgroundColor = UIColor(named: "lightBlue")
                tableView.isUserInteractionEnabled = true
            }
        } else {
            tableView.translateLeftAnim { _ in
                self.animationIsFinished?(true)
                tableView.alpha = 0
                self.cell?.backView.backgroundColor = .lightBlue
                //                self.cell?.propositionLabel.backgroundColor = UIColor(named: "lightBlue")
                tableView.setBackAnim(completion: nil)
                tableView.isUserInteractionEnabled = false
            }
        }
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return UITableView.automaticDimension
    //    }
}
