import Foundation

class HomeViewModel {
    
    private let repository: RecipeRepositoryProtocol
    
    var recipes: [Recipe] = []
//  var recipesDidChange: (() -> Void)?
    var showError: ((String) -> Void)?
    var didSelectRecipe: ((Recipe) -> Void)?
    
    init(repository: RecipeRepositoryProtocol) {
        self.repository = repository
    }
    
    func loadRecipes() async {
        do {
            let recipes = try await repository.fetchRecipes()
            self.recipes = recipes
        } catch {
            showError?("error.fetch-recipes".localized + " " + error.localizedDescription)
        }
    }
    
    func searchRecipes(query: String) async {
        do {
            print("searchRec test1")
            guard !query.isEmpty else {
                await loadRecipes()
                return
            }
            print("searchRec test2 \(query)")

            let recipes = try await repository.search(with: query)
            self.recipes = recipes
            print("searchRec test3 \(recipes.count)")

        } catch {
            showError?("error.serch-recipes".localized + " " + error.localizedDescription)
        }
        
    }
}
