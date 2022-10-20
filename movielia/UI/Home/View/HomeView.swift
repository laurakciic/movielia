//
//  HomeView.swift
//  movielia
//
//  Created by Laura on 16.10.2022..
//

import SwiftUI

struct HomeView: View {        
    var body: some View {
        ScrollView {
            VStack {
                ShowsView()
                ScheduleView()
            }
        }
        .background(Color.primaryBlack)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
