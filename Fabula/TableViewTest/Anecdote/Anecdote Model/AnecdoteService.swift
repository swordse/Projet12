//
//  AnecdoteService.swift
//  Fabula
//
//  Created by Raphaël Goupille on 12/02/2022.
//

import Foundation


class AnecdoteService {
    
    let session: FireStoreSession
    
    init(session: FireStoreSession = DataSession()){
        self.session = session
    }
    
    
    func getAnecdotes(dataRequest: String, callback: @escaping ((Result<[Anecdote], NetworkError>) -> Void)) {
        
        var anecdotes = [Anecdote]()
        
        session.getDocuments(dataRequest: dataRequest) { result, error in
            if error != nil {
                callback(.failure(NetworkError.errorOccured))
            }
            if result != nil {
                callback(.success(self.resultToAnecdote(result: result!)))
            }
        }
    }
    
    func getNewAnecdotes(dataRequest: String, callback: @escaping ((Result<[Anecdote], NetworkError>) -> Void)) {
        
        session.getNewDocuments(dataRequest: dataRequest) { result, error in
            if error != nil {
                callback(.failure(NetworkError.errorOccured))
                print("ERROR getNewAnecdote AnecdoteService")
            }
            if result != nil {
                let anecdotes = self.resultToAnecdote(result: result!)
                callback(.success(anecdotes))
            }
        }
    }
    
    func getAllAnecdotes(dataRequest: String, callback: @escaping ((Result<[Anecdote], NetworkError>) -> Void)) {
        
        session.getAllDocuments(dataRequest: dataRequest) { result, error in
            if error != nil {
                callback(.failure(NetworkError.errorOccured))
            }
            if result != nil {
                print("RESULT FROM DATASESSION: \(result)")
                let anecdotes = self.resultToAnecdote(result: result!)
                callback(.success(anecdotes))
            }
        }
    }
    
    func resultToAnecdote(result: [[String : Any]]) -> [Anecdote] {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        
        let resultAnecdotes: [Anecdote] = result.map { item in
            
            print("****DATE*** = \(String(describing: item["Date"]))")
            let categorie = getCategory(item: item)
            
            return Anecdote(id: item["id"] as! String,
                            categorie:  categorie,
                            title: item["title"] as! String,
                            text: item["text"] as! String,
                            source: (item["source"] as? String) ?? nil,
                            date: formatter.string(from:item["Date"] as! Date),
                            isFavorite: false)
        }
        return resultAnecdotes
    }
    
    func getCategory(item: [String: Any]) -> Category {
        return (Category(rawValue: item["category"] as! String) ?? Category(rawValue: "Picture"))!
    }
    
    func getComments(anecdoteId: String, callback: @escaping (Result<[Comment], NetworkError>) -> Void ) {
        
        session.readComments(dataRequest: DataRequest.comments.rawValue, anecdoteId: anecdoteId) { result, error in
            if error != nil {
                callback(.failure(NetworkError.errorOccured))
            }
            if result != nil {
                guard let comments = result?.map({ element in
                    Comment(anecdoteId: element["anecdoteId"] as! String, commentText: element["commentText"] as! String, date: ((element["date"] as? Date)) ?? Date(), userName: element["userName"] as! String, userId: element["userId"] as! String)
                }) else {
                    callback(.failure(NetworkError.errorOccured))
                    return
                }
                let orderedResult = comments.sorted { $0.date > $1.date
                }
                callback(.success(orderedResult))
            }
        }
    }
    
    func save(commentToSave: [String: Any], anecdoteId: String, completion: @escaping (Bool) -> Void) {
        session.save(commentToSave: commentToSave, anecdoteId: anecdoteId) { bool in
            if bool {
                completion(true)
            }
        }
    }
    
}
