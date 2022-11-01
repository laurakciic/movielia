//
//  ScheduleView.swift
//  movielia
//
//  Created by Laura on 18.10.2022..
//

import SwiftUI

struct ScheduleView<T>: View {
    
    @ObservedObject var viewModel = HomeViewModel<Any>(showsService: ServiceFactory.showsService,
                                                       scheduleService: ServiceFactory.scheduleService,
                                                       castService: ServiceFactory.castService,
                                                       persistanceService: ServiceFactory.persistanceService)
    
    var onGoToDetails: ((_ object: T, _ cast: [CastResponse]) -> Void)?

    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text("Schedule")
                    .foregroundColor(Color.primaryLightGray)
                    .font(.body)
                    .fontWeight(.bold)
                    .padding()
                
                Spacer()
                
                Button {
                    // show scheduled shows for today
                } label: {
                    Text("show all")
                        .foregroundColor(Color.primaryYellow)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .padding()
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 5) {
                    ForEach(viewModel.schedule.prefix(10)) { schedule in
                        ScheduleCardView(schedule: schedule)
                            .onTapGesture {
                                viewModel.fetchCastData(schedule.show.id)
                                onGoToDetails?(schedule as! T, viewModel.cast)
                            }
                    }
                }
            }
            .padding(.horizontal)
            .task {
                viewModel.fetchScheduleData()
            }
        }
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView<Any>()
    }
}
