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
        Button(NSLocalizedString("button.reset", comment: "The button to reset the filter"), action: filter.reset)
    }
    
    var trailingBarItems: some View {
        Button(
            filter.isActive ? NSLocalizedString("button.search", comment: "The button to search.")
                : NSLocalizedString("button.close", comment: "The button to close the view"),
            action: onTrailingButtonTap)
    }
    
    var body: some View {
        NavigationView{
            content
                .navigationTitle(NSLocalizedString("navigationTitle.locations.filter", comment: "The navigation title for the location filter screen."))
                .navigationBarItems(leading: leadingBarItems, trailing: trailingBarItems)
                .navigationBarTitleDisplayMode(.inline)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    var content: some View {
        Form {
            Section {
                FormField(label: NSLocalizedString("label.location.name", comment: "The label for the location's name detail."), value: $filter.name)
                FormField(label: NSLocalizedString("label.location.type", comment: "The label for the location's type detail."), value: $filter.type)
                FormField(label: NSLocalizedString("label.location.dimension", comment: "The label for the location's dimension detail."), value: $filter.dimension)
            }
        }
    }
}
