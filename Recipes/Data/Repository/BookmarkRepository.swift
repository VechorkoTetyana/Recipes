import Foundation

protocol BookmarkRepositoryProtocol {
    func bookmarkRecipe(id: String)
    func unbookmarkRecipe(id: String)
    func isRecipeBookmarked(id: String) -> Bool
}

class BookmarkRepository: BookmarkRepositoryProtocol {
    
    private let userDefaults: UserDefaults
    private var key = "Bookmarks"

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    private func fetchIds() -> [String] {
        userDefaults.array(forKey: key) as? [String] ?? []
    }
    
    func bookmarkRecipe(id: String) {
        var array = fetchIds()
        array.append(id)
        userDefaults.setValue(array, forKey: key)
    }
    
    func unbookmarkRecipe(id: String) {
        var array = fetchIds()
        array.removeAll(where: { $0 == id })
        userDefaults.setValue(array, forKey: key)
    }
    
    func isRecipeBookmarked(id: String) -> Bool {
        fetchIds().contains(id)
    }
}
