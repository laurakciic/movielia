//
//  FavoritesCoordinator.swift
//  movielia
//
//  Created by Laura on 19.10.2022..
//

import UIKit
import SwiftUI

final class FavoritesCoordinator: Coordinator {
    
    var navigationController = UINavigationController()
//    init(navController: UINavigationController) {
//        self.navigationController = navController
//    }
    
    func start() -> UIViewController {
        return createFavoritesViewController()
    }
    
    private func createFavoritesViewController() -> UIViewController {
        let viewController = UIHostingController(rootView: FavoritesView())
        
        viewController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
        
        navigationController.pushViewController(viewController, animated: true)
        
        return viewController
    }
}
