//
//  ExploreViewModel.swift
//  AirBnbClone
//
//  Created by Alex Petrisor on 16.04.2024.
//

import Foundation

class ExploreViewModel: ObservableObject {
    @Published var listings = [Listing]()
    private let service: ExploreService
    @Published var searchLocation = ""
    private var listingsCopy = [Listing]()
    init(service: ExploreService){
        self.service = service
        
        Task { await fetchListings()}
    }
    
    func fetchListings() async {
        do {
            self.listings = try await service.fetchingListings()
            self.listingsCopy = try await service.fetchingListings()
        } catch {
            print("Debug: Failed to fetch listings with error: \(error.localizedDescription)")
        }
    }
    
    func updateListingsForLocation(){
        let filteredListings = listings.filter({
            $0.city.lowercased() == searchLocation.lowercased() ||
            $0.state.lowercased() == searchLocation.lowercased()
        })
        
        self.listings = filteredListings.isEmpty ? listingsCopy : filteredListings
    }
}
