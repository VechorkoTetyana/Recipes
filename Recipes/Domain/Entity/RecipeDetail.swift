import Foundation

struct RecipeDetail: Equatable {
    let id: String
    let name: String
    let imageUrl: String
    let description: String
    let ingredients: [Ingredient]
}

struct Ingredient: Equatable {
    let name: String
    let imageUrl: String
    let amount: String
}
