
import Foundation
import CoreData

final class CoreDataManager {
    // MARK: - Properties
    private let coreDataStack: CoreDataStack
    private let managedObjectContext: NSManagedObjectContext
    
    var favorites: [Favorite] {
        let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        guard let tasks = try? managedObjectContext.fetch(request) else { return [] }
        return tasks
    }
    // MARK: - Initializer
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.mainContext
    }
    // MARK: - Methods
    func createFavorite(anecdote: Anecdote) {
        let favorite = Favorite(context: managedObjectContext)
        favorite.id = anecdote.id
        favorite.text = anecdote.text
        favorite.categorie = anecdote.categorie.rawValue
        favorite.title = anecdote.title
        favorite.source = anecdote.source
        favorite.date = anecdote.date

        coreDataStack.saveContext()
        print("Favori sauvegardé")
        print(favorite)
    }
    
    func deleteAllTasks() {
        favorites.forEach { managedObjectContext.delete($0)}
        coreDataStack.saveContext()
    }
    
    func deleteFavorite(anecdote: Anecdote) {
        
        let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        
        request.predicate = NSPredicate(format: "id == %@", anecdote.id)
        
        guard let favoriteToDelete = try? managedObjectContext.fetch(request) else { print("didn't find favorite for delete")
            return }
        managedObjectContext.delete(favoriteToDelete[0])
        print("Favori effacé")
        print(favoriteToDelete[0])
        coreDataStack.saveContext()
    }
    
}




