//
//  ScheduleCardView.swift
//  movielia
//
//  Created by Laura on 20.10.2022..
//

import SwiftUI

struct ScheduleCardView: View {
    
    var schedule: ScheduleResponse
    
    var body: some View {
        VStack {
            ZStack {
                GeometryReader { geo in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.primaryDarkGray)
                        .frame(width: geo.size.width, height: geo.size.height)
                }
                
                VStack(alignment: .leading) {
                    ZStack {
                        AsyncImage(url: schedule.show.image?.medium) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 200, maxHeight: 200)
                                .padding(.bottom, 10)
                                .cornerRadius(10)
                                .padding(.bottom, -10)
                        } placeholder: {
                            ProgressView()
                                .progressViewStyle(.circular)
                                .frame(maxWidth: 200, maxHeight: 200)
                        }
                        
                        VStack {
                            HStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .strokeBorder(Color.primaryLightGray)
                                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.primaryBlack))
                                        .frame(width: 30, height: 30)
                                    
                                    Button {
                                        // add show to Favorites
                                    } label: {
                                        Image(systemName: "heart.fill")
                                            .foregroundColor(Color.primaryLightGray)
                                            .font(.subheadline)
                                    }
                                }
                                Spacer()
                            }
                            Spacer()
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Spacer()
                            
                            Text(schedule.airtime)
                                .foregroundColor(Color.primaryLightGray)
                                .font(.system(.caption))
                        }
                        Text(schedule.show.name)
                            .foregroundColor(Color.primaryLightGray)
                            .font(.system(.subheadline))
                            .fontWeight(.medium)
                            .lineLimit(1)
                            .frame(maxWidth: 100, alignment: .leading)
                            .padding(.vertical, 10)
                    }
                    .padding(.horizontal, 15)
                }
            }
            Spacer()
            Spacer()
        }
    }
}
