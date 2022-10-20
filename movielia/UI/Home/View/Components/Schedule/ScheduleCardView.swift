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
                GeometryReader { geometry in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.primaryDarkGray)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                }
                
                VStack(alignment: .leading) {
                    AsyncImage(url: schedule.show?.image?.medium) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 200, maxHeight: 200)
                    } placeholder: {
                        ProgressView()
                            .progressViewStyle(.circular)
                    }
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Spacer()
                            
                            Text(schedule.airtime)
                                .foregroundColor(Color.primaryLightGray)
                                .font(.system(.caption))
                        }
                        
                        Text(schedule.show?.name ?? "Name Unavailable")
                            .foregroundColor(Color.primaryLightGray)
                            .font(.system(.subheadline))
                            .fontWeight(.medium)
                            .padding(.vertical)
                    }
                    .padding(.horizontal)
                }
            }
            
            Spacer()
            Spacer()
        }

    }
}
