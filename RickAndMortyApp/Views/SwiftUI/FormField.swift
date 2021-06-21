//
//  FormField.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-21.
//

import SwiftUI

struct FormField: View {
    var label: String
    @Binding var value: String
    var placeholder: String? = nil
    
    var body: some View {
        HStack {
            Text(label)
                .fontWeight(.medium)
            Spacer()
            TextField(label, text: $value)
                .multilineTextAlignment(.trailing)
        }
    }
}
