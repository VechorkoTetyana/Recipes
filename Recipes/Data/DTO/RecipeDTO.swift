import Foundation

struct RecipeDTO: Codable {
    let id: String
    let name: String
    let imageUrl: String
    let duration: Int
}

extension RecipeDTO {
    func toDomain() -> Recipe {
        return Recipe(
            id: id,
            name: name,
            imageUrl: imageUrl,
            duration: duration
        )
    }
}
