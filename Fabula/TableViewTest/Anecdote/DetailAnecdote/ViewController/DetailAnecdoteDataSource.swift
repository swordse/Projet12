
import Foundation
import UIKit

final class DetailAnecdoteDataSource: NSObject {
    
    private var anecdote: Anecdote?
    private var comments: [Comment]?
    private var isFavorite: Bool?
    private var isConnected = false
    
    var commentToSave: ((String, String) -> Void)?
    
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
    // if user is connected, commentButton must show 'ajoutez un commentaire'
    func updateIsConnected(isConnected: Bool) {
        self.isConnected = isConnected
    }
}

extension DetailAnecdoteDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            // section for the detailed anecdote
        case 0: return 1
            // section for the source if available
        case 1:
            return anecdote?.source != nil ? 1 : 0
            // section to tap new comment if authentification succeed
        case 2: return 1
            // section for the comments if available
        case 3: return comments?.count ?? 0
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // index 0 is anecdotedetailtext, index 1 is Source, index 2 makeCommentcell, index3 show comments
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

extension DetailAnecdoteDataSource: WhichButtonTappedProtocol {
    // keep track of the button tapped comment or connexion
    func buttonTapped(isConnexion: Bool, isSubmit: Bool) {
        if isConnexion {
            commentConnexionButtonTapped?(true)
        }
        if isSubmit {
            commentSubmitButtonTapped?(true)
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


