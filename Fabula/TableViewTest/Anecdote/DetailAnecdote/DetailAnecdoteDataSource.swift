
import Foundation
import UIKit


final class DetailAnecdoteDataSource: NSObject {
    
    private var anecdote: Anecdote?
    private var comments: [Comment]?
    private var isFavorite: Bool?
    private var isConnected = false
    
    var commentToSave: ((String, String) -> Void)?
    
    var anecdoteIDForComment: ((String) -> Void)?
    
    var commentConnexionButtonTapped: ((Bool) -> Void)?
    
    var textToShare: ((String) -> Void)?
    
    var commentSubmitButtonTapped: ((Bool) -> Void)?
    
    var scrollToComment: ((Bool) -> Void)?
    
    func updateAnecdote(anecdote: Anecdote) {
        self.anecdote = anecdote
    }
    
    func updateComments(comments: [Comment]) {
        self.comments = comments
    }
    
    func updateIsFavorite(isFavorite: Bool) {
        self.isFavorite = isFavorite
    }
    
    func updateIsConnected(isConnected: Bool) {
        self.isConnected = isConnected
    }
}

extension DetailAnecdoteDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // section for the detailed anecdote
        if section == 0 {
            return 1
        }
        // section for the source if available
        else if section == 1 {
            if anecdote?.source != nil {
                return 1
            } else {
                return 0
            }
        }
        // section to tap new comment if authentification succeed
        else if section == 2 {
            return 1
        }
        // section for the comments if available
        else if section == 3 {
//            guard let comments = comments else {
//                return 0
//            }
//            print("COMMENT COUNT: \(comments!.count)")
            return comments?.count ?? 0
        }
        else {
          return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CommonAnecdoteTableViewCell.identifier, for: indexPath) as? CommonAnecdoteTableViewCell else {
            return UITableViewCell()
        }
            cell.shareDelegate = self
            cell.commentDelegate = self
            guard let anecdote = anecdote, let isFavorite = isFavorite else {
                return UITableViewCell()
            }
            
            cell.setCell(anecdote: anecdote,
                         isFavorite: isFavorite,
                         isDetail: true,
                         dateIsHidden: true,
                         heartIsHidden: false,
                         chevronIsHidden: true)
            
            print("ISFAVORITE DATASOURCE: \(isFavorite)")
        return cell
        }
        
        if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "sourceCell", for: indexPath) as? SourceTableViewCell else {
                return UITableViewCell()
            }
            guard let source = anecdote?.source else {
                return UITableViewCell()
            }
            cell.source = source
            return cell
        }
        
        if indexPath.section == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "makeCommentCell", for: indexPath) as? MakeCommentTableViewCell else {
                return UITableViewCell()
            }
            
            cell.setCell(isConnected: isConnected)
            cell.whichButtonTappedDelegate = self
            return cell
            
        }
        
        if indexPath.section == 3 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as? CommentTableViewCell else {
                return UITableViewCell()
            }
            let comment = comments?[indexPath.row]
            cell.comment = comment
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
}

extension DetailAnecdoteDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
}

//extension DetailAnecdoteDataSource: CommentTappedProtocol {
//    func commentTapped(comment: String?) {
//        guard let comment = comment, let anecdoteId = anecdote?.id else {
//            return
//        }
//        print("comment in datasource delegate: \(comment), \(anecdoteId)")
//        commentToSave?(comment, anecdoteId)
//    }
//}

extension DetailAnecdoteDataSource: WhichButtonTappedProtocol {
    
    func buttonTapped(isConnexion: Bool, isSubmit: Bool) {
        if isConnexion {
            commentConnexionButtonTapped?(true)
        }
        if isSubmit {
            commentSubmitButtonTapped?(true)
            guard let anecdote = anecdote else {
                return
            }
            anecdoteIDForComment?(anecdote.id)
        }
    }
}

// shareButton was tapped in commonTableViewCell
extension DetailAnecdoteDataSource: ShareDelegate {
    func shareTapped(with textToShare: String) {
        self.textToShare?(textToShare)
    }
}
// commentButton was tapped in commonTableViewCell
extension DetailAnecdoteDataSource: CommentDelegate {
    func commentWasTapped(for anecdote: Anecdote) {
        scrollToComment?(true)
    }
    
    
}
