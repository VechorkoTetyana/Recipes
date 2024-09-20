import Foundation

struct RecipeDetailDTO: Codable {
    let id: String
    let name: String
    let imageUrl: String
//    let duration: Int
    let description: String
    let ingredients: [IngredientDTO]
    
    func toDomain() -> RecipeDetail{
        return RecipeDetail(
            id: id,
            name: name,
            imageUrl: imageUrl, 
//            duration: duration,
            description: description,
            ingredients: ingredients.map { $0.toDomain() }
        )
    }
}
