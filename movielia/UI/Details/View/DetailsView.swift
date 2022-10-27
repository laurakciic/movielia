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
        
        if ((viewModel.data as? ShowsResponse) != nil) {
            MovieDetailsView(movie: viewModel.data as! ShowsResponse, cast: viewModel.cast)
        } else if ((viewModel.data as? ScheduleResponse) != nil){
            ScheduleDetailsView(schedule: viewModel.data as! ScheduleResponse, cast: viewModel.cast)
        } else {
            fatalError("Error occured in DetailsView")
        }
        
    }
}

//struct DetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailsView()
//    }
//}
