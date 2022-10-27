//
//  CastCardView.swift
//  movielia
//
//  Created by Laura on 26.10.2022..
//

import SwiftUI

struct CastCardView: View {
    
    var person: CastResponse
    
    var body: some View {
        VStack {
//            GeometryReader { geo in
            AsyncImage(url: person.person?.image?.medium) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 110, height: 150)
                } placeholder: {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .frame(width: 110, height: 150)
                }
//            }
            
            Text(person.person?.name ?? "")
                .font(.caption)
                .fontWeight(.bold)
                .lineLimit(1)
                .foregroundColor(Color.primaryLightGray)
            
            Text(person.person?.character?.name ?? "")
                .lineLimit(1)
                .font(.caption2)
                .foregroundColor(Color.primaryLightGray)
        }
        .multilineTextAlignment(.center)
    }
}
