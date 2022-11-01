//
//  HomeView.swift
//  movielia
//
//  Created by Laura on 16.10.2022..
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel<Any>
    init(viewModel: HomeViewModel<Any>) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ShowsView<Any>(viewModel: viewModel) { object, cast in
                    viewModel.onGoToDetails?(object, cast)
                }
                ScheduleView<Any>(viewModel: viewModel) { object, cast in
                    viewModel.onGoToDetails?(object, cast)
                }
            }
        }
        .navigationBarHidden(true)
        .background(Color.primaryBlack)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel(showsService: ServiceFactory.showsService, scheduleService: ServiceFactory.scheduleService, castService: ServiceFactory.castService, persistanceService: ServiceFactory.persistanceService))
    }
}
