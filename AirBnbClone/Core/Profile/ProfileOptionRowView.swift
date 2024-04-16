//
//  ProfileOptionRowView.swift
//  AirBnbClone
//
//  Created by Alex Petrisor on 13.04.2024.
//

import SwiftUI

struct ProfileOptionRowView: View {
    let imageName: String
    let title: String
    var body: some View {
        VStack{
            HStack{
                Image(systemName: imageName)
                
                Text(title)
                
                Spacer()
                
                Image(systemName: "chevron.right")
            }
            Divider()
        }
    }
}

#Preview {
    ProfileOptionRowView(imageName: "gear", title: "Settings")
}
