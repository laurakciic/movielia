//
//  SearchCoordinator.swift
//  movielia
//
//  Created by Laura on 19.10.2022..
//

import UIKit
import SwiftUI

final class SearchCoordinator: Coordinator {
    
    var navigationController =  UINavigationController()
//    init(navController: UINavigationController) {
//        self.navigationController = navController
//    }
    
    func start() -> UIViewController {
        return createSearchViewController()
    }
    
    private func createSearchViewController() -> UIViewController {
        let viewModel = SearchViewModel(searchService: ServiceFactory.searchService)
        let viewController = UIHostingController(rootView: SearchView(viewModel: viewModel))
        viewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass.fill"))
        navigationController.pushViewController(viewController, animated: true)
        
        return viewController
    }
}
