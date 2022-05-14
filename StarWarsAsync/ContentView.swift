//
//  ContentView.swift
//  StarWarsAsync
//
//  Created by Vikram Kriplaney on 08.05.22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            PeopleList()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
