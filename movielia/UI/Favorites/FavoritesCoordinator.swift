//
//  FavoritesCoordinator.swift
//  movielia
//
//  Created by Laura on 19.10.2022..
//

import UIKit
import SwiftUI

final class FavoritesCoordinator: Coordinator {
    
    var childCoordinator: Coordinator?
    var navigationController = UINavigationController()
    
    func start() -> UIViewController {
        return createFavoritesViewController()
    }
    
    private func createFavoritesViewController() -> UIViewController {
        let viewModel = FavoritesViewModel<Any>(persistanceService: ServiceFactory.persistanceService, castService: ServiceFactory.castService, showsAPIResponse: ShowsResponse.defaultData)
        let viewController = UIHostingController(rootView: FavoritesView(viewModel: viewModel))
        
        viewController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
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
