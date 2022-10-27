//
//  DetailsViewModel.swift
//  movielia
//
//  Created by Laura on 26.10.2022..
//

import SwiftUI

final class DetailsViewModel<T>: ObservableObject {
    
    let data: T
    let cast: [CastResponse]
    
    var onDismissed: (() -> Void)?
    
    init(data: T, cast: [CastResponse]) {
        self.data = data
        self.cast = cast
    }
}
