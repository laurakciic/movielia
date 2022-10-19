//
//  ScheduleView.swift
//  movielia
//
//  Created by Laura on 18.10.2022..
//

import SwiftUI

struct ScheduleView: View {
    
    var body: some View {
        VStack {
            HStack(alignment: .bottom) {
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
            
            ZStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 5) {
                        ForEach(0..<5) { index in
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.primaryDarkGray)
                                .frame(width: 180, height: 200)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}
