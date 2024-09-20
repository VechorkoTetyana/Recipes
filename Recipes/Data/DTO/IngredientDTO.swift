import Foundation

struct IngredientDTO: Codable {
    let name: String
    let imageUrl: String
    let amount: String
    
    func toDomain() -> Ingredient {
        return Ingredient(
        name: name,
        imageUrl: imageUrl,
        amount: amount
        )
    }
}
