import Foundation

class RecipeNetworkRepository: RecipeRepositoryProtocol {
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchRecipes() async throws -> [Recipe] {
        try await networkService.fetch(endpoint: .recipes)
            .map { $0.toDomain() }
    }
    
    func fetchRecipe(id: String) async throws -> RecipeDetail {
        try await networkService.fetch(endpoint: .recipeDetail(id: id))
            .toDomain()
    }
    
    func search(query: String) async throws -> [Recipe] {
        let recipes = try await fetchRecipes()
        return recipes.filter {
            $0.name.lowercased().contains(query.lowercased())
        }
    }
}
