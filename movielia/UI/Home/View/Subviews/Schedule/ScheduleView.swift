//
//  ScheduleView.swift
//  movielia
//
//  Created by Laura on 18.10.2022..
//

import SwiftUI

struct ScheduleView: View {
    
    @ObservedObject var viewModel = HomeViewModel<Any>(showsService: ServiceFactory.showsService,
                                                       scheduleService: ServiceFactory.scheduleService,
                                                       castService: ServiceFactory.castService)
    
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
                    // show scheduled movies for today
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
                                viewModel.fetchCast(schedule.show.id)
                                viewModel.onGoToDetails?(schedule, viewModel.cast)
                                let _ = print("Schedule show id: \(schedule.show.id)")
//                                let _ = print("Schedule cast: \(viewModel.cast)")
                            }
                    }
                }
            }
            .padding(.horizontal)
            .onAppear {
                viewModel.fetchScheduleData()
            }
        }
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}
