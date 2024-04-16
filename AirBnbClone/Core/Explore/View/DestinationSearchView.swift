//
//  DestinationSearchView.swift
//  AirBnbClone
//
//  Created by Alex Petrisor on 13.04.2024.
//

import SwiftUI

enum DestinationSearchOptions {
    case location
    case dates
    case guests
}

struct DestinationSearchView: View {
    @Binding var show: Bool
    @ObservedObject var viewModel: ExploreViewModel
    
    @State private var selectedOption: DestinationSearchOptions = .location
    @State private var fromDate = Date()
    @State private var toDate = Date()
    @State private var guests = 0
    
    
    var body: some View {
        VStack{
            HStack{
                Button{
                    withAnimation(.snappy){
                        show.toggle()
                        viewModel.updateListingsForLocation()
                    }
                } label:{
                    Image(systemName: "xmark.circle")
                        .imageScale(.large)
                        .foregroundStyle(.black)
                }
                Spacer()
                
                if !viewModel.searchLocation.isEmpty {
                    Button("Clear") {
                        viewModel.searchLocation = ""
                        viewModel.updateListingsForLocation()
                    }.foregroundStyle(.black)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
            }
            .padding()
            
            VStack(alignment: .leading){
                if selectedOption == .location{
                    Text("Where to?")
                        .font(.title2)
                        .fontWeight(.semibold)
                    HStack{
                        Image(systemName: "magnifyingglass")
                            .imageScale(.small)
                        TextField("Search destinations", text:$viewModel.searchLocation)
                            .font(.subheadline)
                            .onSubmit {
                                viewModel.updateListingsForLocation()
                                show.toggle()
                            }
                        
                    }
                    .frame(height: 44)
                    .padding(.horizontal)
                    .overlay{
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(lineWidth: 1)
                            .foregroundStyle(Color(.systemGray4))
                    }
                }
                else {
                    CollapsedPickerView(title: "Where", subtitle: "Add destination")
                }
            }
            .modifier(CollapsibleDestinationViewModifier())
            .frame(height: selectedOption == .location ? 120 : 64)
            .onTapGesture {
                withAnimation(.snappy){selectedOption = .location}
            }
            
            VStack{
                if selectedOption == .dates {
                    
                    VStack(alignment: .leading){
                        
                        Text("When's your trip?")
                            .fontWeight(.bold)
                            .font(.title3)
                            .padding(.bottom)
                        
                        VStack{
                            DatePicker(
                                "From",
                                selection: $fromDate,
                                displayedComponents: .date
                            )
                            .padding(.vertical, 4)
                            
                            Divider()
                            
                            DatePicker(
                                "To",
                                selection: $toDate,
                                displayedComponents: .date
                            )
                            .padding(.vertical, 4)
                        }
                        .foregroundStyle(.gray)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        
                    }
                } else {
                    CollapsedPickerView(title:"When" , subtitle: "Add dates")
                }
            }
            .modifier(CollapsibleDestinationViewModifier())
            .frame(height: selectedOption == .dates ? 180 : 64)
            .onTapGesture {
                withAnimation(.snappy){selectedOption = .dates}
            }
            
            VStack(alignment: .leading){
                if selectedOption == .guests {
                    Text("Who's coming?")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    HStack{
                        Stepper{
                            Text("\(guests) Adults")
                                .font(.footnote)
                                .fontWeight(.semibold)
                        } onIncrement: {
                            guests+=1
                        } onDecrement: {
                            guard guests > 0 else { return }
                            guests-=1
                        }
                    }
                    
                } else {
                    CollapsedPickerView(title:"Who" , subtitle: "Add guests")
                }
            }
            .modifier(CollapsibleDestinationViewModifier())
            .frame(height: selectedOption == .guests ? 120 : 64)
            .onTapGesture {
                withAnimation(.snappy){selectedOption = .guests}
            }
            Spacer()
        }
    }
}

#Preview {
    DestinationSearchView(show: .constant(false),
                          viewModel: ExploreViewModel(service: ExploreService()))
}

struct CollapsibleDestinationViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
        
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding()
            .shadow(radius: 10)
    }
}

struct CollapsedPickerView: View {
    let title: String
    let subtitle: String
    var body: some View {
        HStack{
            Text(title)
                .foregroundStyle(.gray)
            
            Spacer()
            
            Text(subtitle)
                .foregroundStyle(.black)
        }
        .font(.subheadline)
        .fontWeight(.semibold)
    }
}
