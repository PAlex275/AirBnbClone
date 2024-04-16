//
//  WishListView.swift
//  AirBnbClone
//
//  Created by Alex Petrisor on 13.04.2024.
//

import SwiftUI

struct WishListView: View {
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 24){
                VStack(alignment: .leading, spacing: 4){
                    Text("Log in to view your wishlists")
                        .font(.headline)
                    
                    Text("You can create, view or edit wishlists once you've logged in")
                        .font(.footnote)
                }.padding()
                
                Button {} label: {
                    Text("Log in")
                        .foregroundStyle(.white)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(width: 360,height: 48)
                        .background(.pink)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                Spacer()
            }
            .navigationTitle("WishLists")
            .padding()
        }
    }
}

#Preview {
    WishListView()
}
