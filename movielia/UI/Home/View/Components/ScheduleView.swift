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
            
            ZStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 5) {
                        ForEach(0..<5) { index in
                            AsyncImage(url: URL(string: "https://static.tvmaze.com/uploads/images/medium_portrait/0/3.jpg")) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                Color.primaryDarkGray
                            }
                            .frame(width: 180, height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
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
