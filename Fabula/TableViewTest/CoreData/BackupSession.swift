//
//  BackupSession.swift
//  Fabula
//
//  Created by Raphaël Goupille on 17/02/2022.
//

import Foundation
/// protocol to handle coreData
protocol BackupSession {
    
    var favorites: [Favorite] { get }
    
    func createFavorite(anecdote: Anecdote)
    
    func deleteFavorite(anecdote: Anecdote)
    
    func deleteAllFavorites() 
}
