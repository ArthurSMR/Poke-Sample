//
//  ContentView.swift
//  Poke-Sample
//
//  Created by Arthur Rodrigues on 30/06/20.
//  Copyright © 2020 Arthur Rodrigues. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        // 5
        NavigationView {
            
            // 3 etapa
            List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                NavigationLink(destination: PokemonDetail()) {
                    PokemonCell()
                }
            }
            // 6 - onAppearWay
            // 7
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Pokemons", displayMode: .automatic)
        }
    }
}

// 4
struct PokemonCell: View {
    var body: some View {
        
        // 2
        HStack {
            Image("pikachu")
            
            // 1
            VStack(alignment: .leading) {
                Text("Nome")
                    .font(.headline)
                Text("Localização")
                    .font(.subheadline)
                Text("Tipo")
                    .font(.subheadline)
            }
        }
    }
}

/* Etapas:
 
 1- Fazer VStack (Nome/localizacao/tipo)
 2- HStack com image(pikachu)
 3- Fazer uma lista de pokemons
 4- Extrair view para pokemon Cell
 5- Criar navigation view
 6- mostrar o on appear way
 7- modifiers navigation view
 
 */

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
