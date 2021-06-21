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
                .navigationTitle(NSLocalizedString("navigationTitle.episodes.filter", comment: "The navigation title for the location filter screen."))
                .navigationBarItems(leading: leadingBarItems, trailing: trailingBarItems)
                .navigationBarTitleDisplayMode(.inline)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    var content: some View {
        Form {
            Section {
                FormField(label: NSLocalizedString("label.episode.name", comment: "The label for the episode's name detail."), value: $filter.name)
                FormField(label: NSLocalizedString("label.episode.episode", comment: "The label for the episode's episode detail."), value: $filter.episode)
            }
        }
    }
}
