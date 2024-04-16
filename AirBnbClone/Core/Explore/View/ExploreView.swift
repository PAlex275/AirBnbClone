//
//  ExploreView.swift
//  AirBnbClone
//
//  Created by Alex Petrisor on 11.04.2024.
//

import SwiftUI

struct ExploreView: View {
    @State private var showDestinationSearchView = false
    @StateObject var viewModel = ExploreViewModel(service: ExploreService())
    var body: some View {
        NavigationStack {
            if showDestinationSearchView {
                DestinationSearchView(show: $showDestinationSearchView,
                                      viewModel: viewModel)
                   
            }
            else {
                SearchAndFilterBar(location: $viewModel.searchLocation)
                    .onTapGesture {
                    withAnimation(.easeIn){
                        showDestinationSearchView = true
                    }
                }
                
                ScrollView{
                    LazyVStack(spacing: 32){
                        ForEach(viewModel.listings){listing in
                            NavigationLink(value: listing){
                                ListingItemView(listing: listing)
                                    .frame(height: 400)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            
                        }
                    }
                }
                .navigationDestination(for: Listing.self) { listing in
                    ListingDetailView(listing: listing)
                        .navigationBarBackButtonHidden()
                }
            }
            
        }
    }
}

#Preview {
    ExploreView()
}
