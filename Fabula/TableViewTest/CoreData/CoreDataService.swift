////
////  CoreDataService.swift
////  Fabula
////
////  Created by Raphaël Goupille on 17/02/2022.
////
//
//import Foundation
//
//class CoreDataService {
//    
//    let session: BackupSession
//    
//    init(session: BackupSession = CoreDataSession(coreDataStack: CoreDataStack())){
//        self.session = session
//    }
//    
//    func getFavorites() -> [Favorite]? {
//        return session.favorites
//    }
//    
//    
//    func createFavorite(anecdote: Anecdote) {
//        session.createFavorite(anecdote: anecdote)
//    }
//    
//    func deleteAllFavorites() {
//        session.deleteAllFavorites()
//    }
//    
//    func deleteFavorite(anecdote: Anecdote) {
//        session.deleteFavorite(anecdote: anecdote)
//    }
//    
//}
