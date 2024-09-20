import UIKit

class AppCoordinator {
    
    private let window: UIWindow
    private let container: DependencyContainer
    
    init(window: UIWindow, container: DependencyContainer) {
        self.window = window
        self.container = container
    }
    
    func start() {
        let tabBarController = UITabBarController()
        
        tabBarController.viewControllers = [
            setupHomeVC(),
            setupDiscovery(),
            setupBookmarksVC(),
            setupProfileVC()
        ]
        
 /*       let container = DependencyContainer()
        let navigationController = UINavigationController()
        let homeCoordinator = HomeCoordinator(
            container: container,
            navigationController: navigationController
        )
        homeCoordinator.start()
  */
        
//        window.rootViewController = navigationController
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
    
    private func setupHomeVC() -> UIViewController {
        
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(
            title: "tabBar.home".localized,
            image: UIImage(named: "home"),
            tag: 1
        )
        
        let homeCoordinator = HomeCoordinator(
            container: container,
            navigationController: navigationController
        )
        homeCoordinator.start()
        
        return navigationController
    }
    
    private func setupDiscovery() -> UIViewController {
        let discoveryVC = UIViewController()
        discoveryVC.view.backgroundColor = .background
        discoveryVC.tabBarItem = UITabBarItem(
            title: "tabBar.discovery".localized,
            image: UIImage(named: "discovery"),
            tag: 1
        )
        return discoveryVC
    }
    
    private func setupBookmarksVC() -> UIViewController {
        let bookmarksVC = UIViewController()
        bookmarksVC.view.backgroundColor = .background
        bookmarksVC.tabBarItem = UITabBarItem(
            title: "tabBar.bookmarks".localized,
            image: UIImage(named: "bookmark"),
            tag: 1
        )
        return bookmarksVC
    }
    
    private func setupProfileVC() -> UIViewController {
        let profileVC = UIViewController()
        profileVC.view.backgroundColor = .background
        profileVC.tabBarItem = UITabBarItem(
            title: "tabBar.profile".localized,
            image: UIImage(named: "profile"),
            tag: 1
        )
        return profileVC
    }
}

