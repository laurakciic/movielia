//
//  ScheduleDetailsView.swift
//  movielia
//
//  Created by Laura on 26.10.2022..
//

import SwiftUI

struct ScheduleDetailsView: View {
    
    var schedule: ScheduleResponse      
    var cast: [CastResponse]
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    ZStack {
                        AsyncImage(url: schedule.show.image?.original) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: geo.size.width, height: geo.size.height / 1.58)
                                .ignoresSafeArea()
                        } placeholder: {
                            ProgressView()
                                .progressViewStyle(.circular)
                                .frame(width: geo.size.width, height: geo.size.height / 1.58)
                        }
                        
                        VStack {
                            HStack {
                                Spacer()
                                
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .strokeBorder(Color.primaryLightGray)
                                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.primaryBlack))
                                        .frame(width: 40, height: 40)
                                    
                                    Button {
                                        // add show to Favorites
                                    } label: {
                                        Image(systemName: "heart.fill")
                                            .foregroundColor(Color.primaryLightGray)
                                            .font(.title3)
                                    }
                                }
                                .padding(.horizontal)
                            }
                            
                            Spacer()
                        }
                    }
                    
                    Text(schedule.show.summary ?? "Summary not available.")
                        .foregroundColor(Color.primaryLightGray)
                        .padding(.horizontal, 4)
                        .multilineTextAlignment(.leading)
                    
                    HStack {
                        Text("Cast")
                            .foregroundColor(Color.primaryLightGray)
                            .font(.title3)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Button {
                            // show all cast
                        } label: {
                            Text("show all")
                                .foregroundColor(Color.primaryYellow)
                                .font(.subheadline)
                                .fontWeight(.medium)
                        }
                    }
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 5) {
                            ForEach(cast.prefix(10), id: \.person?.id) { person in
                                CastCardView(person: person)
                            }
                        }
                    }
                }
            }
        }
        .background(Color.primaryBlack)
    }
}

//struct ScheduleDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScheduleDetailsView()
//    }
//}
