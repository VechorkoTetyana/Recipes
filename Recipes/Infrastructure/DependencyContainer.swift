import Foundation

class DependencyContainer {
    
    lazy var recipeDataSource: LocalRecipeDataSourceProtocol = {
        LocalRecipeDataSource()
    }()
    
    lazy var recipeRepository: RecipeRepositoryProtocol = {
        return RecipeRepository(dataSource: recipeDataSource)
    }()
    
    lazy var bookmarkRepository: BookmarkRepositoryProtocol = {
        BookmarkRepository(userDefaults: .standard)
    }()
}
