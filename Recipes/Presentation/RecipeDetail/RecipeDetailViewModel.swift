import UIKit

class RecipeDetailViewModel {
    var recipeDetail: RecipeDetail?
    var showError: ((String) -> Void)?
    
    private let repository: RecipeRepositoryProtocol
    private let id: String

    init(id: String, repository: RecipeRepositoryProtocol) {
        self.id = id
        self.repository = repository
    }

    func loadRecipeDetail() async {
        do {
            let recipeDetail = try await repository.fetchRecipe(id: id)
            await MainActor.run {
                self.recipeDetail = recipeDetail
            }
        }
        catch {
            showError?("\("error.fetch-recipe-detail".localized) \(error.localizedDescription)")
        }
    }
}
