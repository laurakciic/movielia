//
//  DetailsView.swift
//  movielia
//
//  Created by Laura on 26.10.2022..
//

import SwiftUI

struct DetailsView<T>: View {
    
    @ObservedObject var viewModel: DetailsViewModel<T>
    
    var body: some View {
        
        ZStack {
            if ((viewModel.data as? ShowsResponse) != nil) {
                MovieDetailsView(viewModel: viewModel, show: viewModel.data as! ShowsResponse, cast: viewModel.cast)
            } else if ((viewModel.data as? ScheduleResponse) != nil){
                ScheduleDetailsView(viewModel: viewModel, schedule: viewModel.data as! ScheduleResponse, cast: viewModel.cast)
            } else {
                fatalError("Error occured in DetailsView")
            }
        }
    }
}
