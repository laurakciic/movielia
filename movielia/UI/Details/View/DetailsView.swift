//
//  DetailsView.swift
//  movielia
//
//  Created by Laura on 26.10.2022..
//

import SwiftUI

struct DetailsView<T>: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: DetailsViewModel<T>
    
    var body: some View {
        
        ZStack {
            Group {
                if ((viewModel.data as? ShowsResponse) != nil) {
                    MovieDetailsView(movie: viewModel.data as! ShowsResponse, cast: viewModel.cast)
                } else if ((viewModel.data as? ScheduleResponse) != nil){
                    ScheduleDetailsView(schedule: viewModel.data as! ScheduleResponse, cast: viewModel.cast)
                } else {
                    fatalError("Error occured in DetailsView")
                }
            }
            
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                    .font(.system(.headline))
                    .font(.footnote.weight(.heavy))
                    .foregroundColor(Color.primaryWhite)
                    
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
                }
                
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}
