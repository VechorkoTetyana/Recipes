import UIKit

class RecipeDetailCoordinator: Coordinator {
    
    private let container: DependencyContainer
    private let id: String
    var navigationController: UINavigationController
    
    init(id: String, container: DependencyContainer, navigationController: UINavigationController) {
        self.id = id
        self.container = container
        self.navigationController = navigationController
    }
   
    func start() {
        let viewModel = RecipeDetailViewModel(id: id, container: container)
        let viewController = RecipeDetailViewController(viewModel: viewModel)
      
        navigationController.pushViewController(viewController, animated: true)
    
    }
}
