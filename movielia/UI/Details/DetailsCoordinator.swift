//
//  DetailsCoordinator.swift
//  movielia
//
//  Created by Laura on 26.10.2022..
//

import SwiftUI

final class DetailsCoordinator<T>: Coordinator {
    
    var onDismissed: (() -> Void)?
    
    let data: T
    let cast: [CastResponse]
    
    init(data: T, cast: [CastResponse]) {
        self.data = data
        self.cast = cast
    }
    
    func start() -> UIViewController {
        let viewModel = DetailsViewModel<T>(data: data, cast: cast, persistanceService: ServiceFactory.persistanceService)
        let viewController = UIHostingController(rootView: DetailsView<T>(viewModel: viewModel))
        
        viewModel.onDismissed = { [weak self] in
            self?.onDismissed?()
        }
        
        return viewController
    }
    
}
