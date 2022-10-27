//
//  MainCoordinator.swift
//  movielia
//
//  Created by Laura on 17.10.2022..
//

import UIKit
import SwiftUI

final class MainCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController = UINavigationController()
    private var tabBarController = UITabBarController()
        
    func start() -> UIViewController {
        return startTabbar()
    }
    
    func startTabbar() -> UINavigationController {
        childCoordinators = [
            HomeCoordinator(navigationController: navigationController),
            SearchCoordinator(),
            FavoritesCoordinator()
        ]
        
        createTabBar()
        navigationController.viewControllers = [tabBarController]
        return navigationController
    }
    
    func createTabBar() {
        tabBarController = UITabBarController()
    
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        UITabBar.appearance().standardAppearance = appearance
        
        tabBarController.tabBar.tintColor = UIColor(Color.primaryYellow)
        tabBarController.tabBar.backgroundColor = UIColor(Color.primaryDarkGray)
        tabBarController.tabBar.unselectedItemTintColor = UIColor(Color.primaryLightGray)
        tabBarController.viewControllers = childCoordinators.map { coordinator in
            coordinator.start()
        }
    }
}
