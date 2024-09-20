import Foundation

protocol RecipeRepositoryProtocol {
    func fetchRecipes() async throws -> [Recipe]
    func fetchRecipe(id: String) async throws -> RecipeDetail 
    func search(with query: String) async throws -> [Recipe]
}

class RecipeRepository: RecipeRepositoryProtocol {
    
    private let dataSource: LocalRecipeDataSourceProtocol
    
    init(dataSource: LocalRecipeDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func fetchRecipes() async throws -> [Recipe] {
        let recipeDTOs =  try dataSource.fetchRecipes()
        return recipeDTOs.map { $0.toDomain() }
    }
    
    func fetchRecipe(id: String) async throws -> RecipeDetail {
        let recipeDetailDTO = try dataSource.fetchRecipe(with: id)
        return recipeDetailDTO.toDomain()
    }
    
    func search(with query: String) async throws -> [Recipe] {
        let recipes = try await fetchRecipes()
        return recipes.filter {
            $0.name.lowercased().contains(query.lowercased())
        }
    }
}
