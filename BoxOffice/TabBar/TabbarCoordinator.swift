
import UIKit

class TabBarCoordinator: Coordinator {
    private var movieTableCoordinator: MovieTableCoordinator?
    private var movieCollectionCoordinator: MovieCollectionCoordinator?
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let tabBarController = MainTabBarController()
        tabBarController.coordinator = self
        
        let controllerList = getControllers()
        
        if let movieTableNavigationController = controllerList.first as? UINavigationController {
            self.movieTableCoordinator = MovieTableCoordinator(navigationController: movieTableNavigationController)
        }
        
        if let movieCollectionNavigationController = controllerList[1] as? UINavigationController {
            self.movieCollectionCoordinator = MovieCollectionCoordinator(navigationController: movieCollectionNavigationController)
        }
        
        tabBarController.viewControllers = controllerList
        tabBarController.modalPresentationStyle = .fullScreen
        navigationController.present(tabBarController, animated: false, completion: nil)
        
        coordinateToSubNavigation()
    }
    
    func coordinateToSubNavigation() {
        if let movieTableCoordinator = movieTableCoordinator {
            movieTableCoordinator.start()
        }
        
        if let movieCollectionCoordinator = movieCollectionCoordinator {
            movieCollectionCoordinator.start()
        }
    }
    
    private func getControllers() -> [UIViewController] {
        let movieTableNavigationController = ReuseNavigationViewController()
        movieTableNavigationController.tabBarItem = UITabBarItem(title: "TableView", image: UIImage(named: "ic_table"), tag: 0)
        
        let movieCollectionNavigationController = ReuseNavigationViewController()
        movieCollectionNavigationController.tabBarItem = UITabBarItem(title: "CollectionView", image: UIImage(named: "ic_collection"), tag: 1)
        
        let controllerList = [movieTableNavigationController, movieCollectionNavigationController]
        
        return controllerList
    }
}
