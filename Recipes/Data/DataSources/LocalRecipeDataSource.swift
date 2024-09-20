import Foundation

protocol LocalRecipeDataSourceProtocol {
    func fetchRecipes() throws -> [RecipeDTO]
    func fetchRecipe(with id: String) throws -> RecipeDetailDTO
}

class LocalRecipeDataSource: LocalRecipeDataSourceProtocol {
    private let decoder: JSONDecoder
    
    init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }
    
    func fetchRecipes() throws -> [RecipeDTO] {
        return try fetchFile(with: "recipes")
        
/*        guard let url = Bundle.main.url(forResource: "recipes", withExtension: "json") else {
            throw LocalRecipeDataSourceError.fileNotFound("recipes.json")
        }
        
        let data = try Data(contentsOf: url)
        return try decoder.decode([RecipeDTO].self, from: data) */
        
    }
    
    func fetchRecipe(with id: String) throws -> RecipeDetailDTO {
        print("fetchRecipe test1")
        
        let result: RecipeDetailDTO = try fetchFile(with: "recipe_detail_\(id)")
        
        print("fetchRecipe test2")
        
        return result

 /*       guard let url = Bundle.main.url(forResource: "recipe_detail_\(id)", withExtension: "json") else {
            throw LocalRecipeDataSourceError.fileNotFound("recipe_detail_\(id).json")
        }
        
        let data = try Data(contentsOf: url)
        return try decoder.decode([RecipeDetailDTO].self, from: data) */
        
    }
    
    private func fetchFile<DTO: Decodable>(with fileName: String) throws -> DTO {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            print("fetchFile fileNotFound")
            throw LocalRecipeDataSourceError.fileNotFound("\(fileName).json")
        }
        
        let data = try Data(contentsOf: url)
        return try decoder.decode(DTO.self, from: data)
    }
}
