import Foundation

extension Endpoint {
    static var recipes: Endpoint<[RecipeDTO]> {
        Endpoint<[RecipeDTO]>(path: "recipes.json")
    }
    
    static func recipeDetail(id: String) -> Endpoint<RecipeDetailDTO> {
        Endpoint<RecipeDetailDTO>(path: "recipeDetail/\(id).json")
    }
}
