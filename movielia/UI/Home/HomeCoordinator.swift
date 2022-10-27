//
//  HomeCoordinator.swift
//  movielia
//
//  Created by Laura on 17.10.2022..
//

import UIKit
import SwiftUI

final class HomeCoordinator: Coordinator {
    
    var childCoordinator: Coordinator?
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() -> UIViewController {
        return createHomeViewController()
    }
    
    private func createHomeViewController() -> UIViewController {
        let viewController = UIHostingController(rootView: HomeView())
        viewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
//        navigationController?.pushViewController(viewController, animated: true)
        
        let viewModel = HomeViewModel<Any>(showsService: ServiceFactory.showsService, scheduleService: ServiceFactory.scheduleService, castService: ServiceFactory.castService)
        
        viewModel.onGoToDetails = { [weak self] movie, cast in
            self?.goToDetails(object: movie, cast: cast)
        }
        
        return viewController
    }
    
    private func goToDetails<T>(object: T, cast: [CastResponse]) {
        let detailsCoordinator = DetailsCoordinator(data: object, cast: cast)
        childCoordinator = detailsCoordinator
//        childCoordinator?.append(detailsCoordinator)
        print("------ Child coordinator: \(childCoordinator!) ----------")

        detailsCoordinator.onDismissed = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
            self?.childCoordinator = nil
        }

        let detailsViewController = detailsCoordinator.start()
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
