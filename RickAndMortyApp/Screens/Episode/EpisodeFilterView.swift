//
//  EpisodeFilterView.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-21.
//

import SwiftUI

struct EpisodeFilterView: View {
    
    @ObservedObject var filter: EpisodeFilter
    
    var onTrailingButtonTap: ()->()
    
    init(filter: EpisodeFilter, onTrailingButtonTap: @escaping ()->()) {
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
                .navigationTitle("Filter Episodes")
                .navigationBarItems(leading: leadingBarItems, trailing: trailingBarItems)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var content: some View {
        Form {
            Section(header: Text("Filters (Optional)")) {
                FormField(label: "Name", value: $filter.name)
                FormField(label: "Episode", value: $filter.episode)
            }
        }
    }
}
