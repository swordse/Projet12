

import Foundation
import UIKit

struct Section {
    
    var title: String
    var text: String
//    var image: UIImage
    var icon: UIImage
    var color: UIColor
    
    
    static var menuCategories = [Section(title: "Anecdotes", text: "Des anecdotes insolites", icon: UIImage(named: "BookMenu")!, color: UIColor.systemPink),
                                 Section(title: "Citations", text: "Une citation par jour", icon: UIImage(named: "QuoteMenu")!, color: UIColor.systemPurple),
                                 Section(title: "Mot du jour", text: "Un nouveau mot par jour", icon: UIImage(named:"WordMenu")!, color: UIColor.systemIndigo),
                                 Section(title: "Quizz", text: "Testez vos connaissances", icon: UIImage(named: "GameMenu")!, color: UIColor.systemOrange),
                                 Section(title: "Autour de vous", text: "Apprenez en vous promenant", icon: UIImage(named: "MapMenu")!, color: UIColor.systemBlue)]
    
}

