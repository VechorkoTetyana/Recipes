import Foundation

class RecipesNetworkConfig: NetworkConfig {
    let baseUrl: URL = URL(string:
        "https://recipes-ecbaa-default-rtdb.europe-west1.firebasedatabase.app/"
    )!
}

