//
//  ExploreService.swift
//  AirBnbClone
//
//  Created by Alex Petrisor on 16.04.2024.
//

import Foundation

class ExploreService {
    func fetchingListings() async throws -> [Listing] {
        return DeveloperPreview.shared.listings
    }
}
