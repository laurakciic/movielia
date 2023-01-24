//
//  SearchCoordinator.swift
//  movielia
//
//  Created by Laura on 19.10.2022..
//

import UIKit
import SwiftUI

final class SearchCoordinator: Coordinator {
    
    var childCoordinator: Coordinator?
    var navigationController =  UINavigationController()
    
    func start() -> UIViewController {
        return createSearchViewController()
    }
    
    private func createSearchViewController() -> UIViewController {
        let viewModel = SearchViewModel<Any>(searchService: ServiceFactory.searchService, showsAPIResponse: ShowsResponse.defaultData, castService: ServiceFactory.castService)
        
        let viewController = UIHostingController(rootView: SearchView(viewModel: viewModel))
        
        viewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass.fill"))
//        navigationController.pushViewController(viewController, animated: true)
        
        viewModel.onGoToDetails = { [weak self] show, cast in
            self?.goToDetails(show: show, cast: cast)
        }
        
        return viewController
    }
    
    private func goToDetails(show: ShowsResponse, cast: [CastResponse]) {
        let detailsCoordinator = DetailsCoordinator(data: show, cast: cast)
        childCoordinator = detailsCoordinator

        detailsCoordinator.onDismissed = { [weak self] in
            self?.navigationController.popViewController(animated: true)
            self?.childCoordinator = nil
        }

        let detailsViewController = detailsCoordinator.start()
        self.navigationController.pushViewController(detailsViewController, animated: true)
    }
}
