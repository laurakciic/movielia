//
//  ShowsView.swift
//  movielia
//
//  Created by Laura on 18.10.2022..
//

import SwiftUI

struct ShowsView: View {
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text("Shows")
                    .foregroundColor(Color.primaryLightGray)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                Spacer()
                
                Button {
                    // show few movies
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
                                .frame(width: 200, height: 300)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct ShowsView_Previews: PreviewProvider {
    static var previews: some View {
        ShowsView()
    }
}
