//
//  LocationFilterView.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-21.
//

import SwiftUI

struct LocationFilterView: View {
    
    @ObservedObject var filter: LocationFilter
    
    var onTrailingButtonTap: ()->()
    
    init(filter: LocationFilter, onTrailingButtonTap: @escaping ()->()) {
        self.filter = filter
        self.onTrailingButtonTap = onTrailingButtonTap
    }
    
    var leadingBarItems: some View {
        Button("Reset", action: filter.reset)
    }
    
    var trailingBarItems: some View {
        Button(filter.isActive ? "Search" : "Close", action: onTrailingButtonTap)
    }
    
    var body: some View {
        NavigationView{
            content
                .navigationTitle("Filter Locations")
                .navigationBarItems(leading: leadingBarItems, trailing: trailingBarItems)
                .navigationBarTitleDisplayMode(.inline)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    var content: some View {
        Form {
            Section(header: Text("Filters (Optional)")) {
                FormField(label: "Name", value: $filter.name)
                FormField(label: "Type", value: $filter.type)
                FormField(label: "Dimension", value: $filter.dimension)
            }
        }
    }
}
