//
//  CharacterFilterView.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-21.
//

import SwiftUI

struct CharacterFilterView: View {
    
    @ObservedObject var filter: CharacterFilter
    
    var onTrailingButtonTap: ()->()
    
    init(filter: CharacterFilter, onTrailingButtonTap: @escaping ()->()) {
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
                .navigationTitle(NSLocalizedString("navigationTitle.characters.filter", comment: "The navigation title for the character filter screen."))
                .navigationBarItems(leading: leadingBarItems, trailing: trailingBarItems)
                .navigationBarTitleDisplayMode(.inline)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    var content: some View {
        Form {
            Section {
                FormField(label: NSLocalizedString("label.character.name", comment: "The label for the character's name detail."), value: $filter.name)
                
                Picker(selection: $filter.status, label: Text(NSLocalizedString("label.character.status", comment: "The label for the character's status detail.")).formLabelStyle()) {
                    ForEach(filter.statusOptions, id: \.self) { option in
                        Text(option).formLabelStyle().tag(option)
                    }
                }
                
                FormField(label: NSLocalizedString("label.character.species", comment: "The label for the character's species detail."), value: $filter.species)
                FormField(label: NSLocalizedString("label.character.type", comment: "The label for the character's type detail."), value: $filter.type)
                
                Picker(selection: $filter.gender, label: Text(NSLocalizedString("label.character.gender", comment: "The label for the character's gender detail.")).formLabelStyle()) {
                    ForEach(filter.genderOptions, id: \.self) { option in
                        Text(option).formLabelStyle().tag(option)
                    }
                }
            }
        }
    }
}
