import Foundation

class DependencyContainer {
    
    lazy var recipeDataSource: LocalRecipeDataSourceProtocol = {
        LocalRecipeDataSource()
    }()
    
/*    lazy var recipeRepository: RecipeRepositoryProtocol = {
        return RecipeRepository(dataSource: recipeDataSource)
    }()
 */
    
    lazy var recipeRepository: RecipeRepositoryProtocol = {
        return RecipeNetworkRepository(networkService: networkService)
    }()
    
    lazy var networkService: NetworkServiceProtocol = {
        let config = RecipesNetworkConfig()
        return NetworkService(config: config)
    }()
    
    lazy var bookmarkRepository: BookmarkRepositoryProtocol = {
        BookmarkRepository(userDefaults: .standard)
    }()
    
}
