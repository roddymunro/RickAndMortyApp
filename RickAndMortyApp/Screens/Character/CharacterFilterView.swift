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
        Button("Reset", action: filter.reset)
    }
    
    var trailingBarItems: some View {
        Button(filter.isActive ? "Search" : "Close", action: onTrailingButtonTap)
    }
    
    var body: some View {
        NavigationView{
            content
                .navigationTitle("Filter Characters")
                .navigationBarItems(leading: leadingBarItems, trailing: trailingBarItems)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var content: some View {
        Form {
            Section(header: Text("Filters (Optional)")) {
                FormField(label: "Name", value: $filter.name)
                
                Picker(selection: $filter.status, label: Text("Status").formLabelStyle()) {
                    ForEach(filter.statusOptions, id: \.self) { option in
                        Text(option).formLabelStyle().tag(option)
                    }
                }
                
                FormField(label: "Species", value: $filter.species)
                FormField(label: "Type", value: $filter.type)
                
                Picker(selection: $filter.gender, label: Text("Gender").formLabelStyle()) {
                    ForEach(filter.genderOptions, id: \.self) { option in
                        Text(option).formLabelStyle().tag(option)
                    }
                }
            }
        }
    }
}
