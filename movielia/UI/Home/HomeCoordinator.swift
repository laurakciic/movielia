//
//  HomeCoordinator.swift
//  movielia
//
//  Created by Laura on 17.10.2022..
//

import UIKit
import SwiftUI

final class HomeCoordinator: Coordinator {
    
    var navigationController: UINavigationController?
    
    init(navController: UINavigationController) {
        self.navigationController = navController
    }
    
    func start() -> UIViewController {
        return createHomeViewController()
    }
    
    private func createHomeViewController() -> UIViewController {
        let viewController = UIHostingController(rootView: HomeView())
        viewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        navigationController?.pushViewController(viewController, animated: true)
        
        return viewController
    }
    
}
