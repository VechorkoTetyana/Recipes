import Foundation

class BookmarksViewModel {
    
    private let bookmarkRepository: BookmarkRepositoryProtocol
    private let recipyRepository: RecipeRepositoryProtocol
    
    var bookmarkedRecipes: [Recipe] = []
    var didSelectRecipe: ((Recipe) -> Void)?
    var showError: ((String) -> Void)?

    init(
        bookmarkRepository: BookmarkRepositoryProtocol,
        recipyRepository: RecipeRepositoryProtocol
    ) {
        self.bookmarkRepository = bookmarkRepository
        self.recipyRepository = recipyRepository
    }
    
    func loadBookmarkedRecipes() async {
        do {
            let bookmarkedIds = bookmarkRepository.fetchIds()
            let allRecipes = try await recipyRepository.fetchRecipes()
            let bookmarkedRecipes = allRecipes.filter {
                bookmarkedIds.contains($0.id)
            }
            
            await MainActor.run {
                self.bookmarkedRecipes = bookmarkedRecipes
            }
        }
        catch {
            showError?("error.fetch-recipes".localized + " " + error.localizedDescription)

        }
    }
}
