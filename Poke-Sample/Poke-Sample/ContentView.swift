//
//  ContentView.swift
//  Poke-Sample
//
//  Created by Arthur Rodrigues on 30/06/20.
//  Copyright © 2020 Arthur Rodrigues. All rights reserved.
//

import SwiftUI

struct ContentView<ViewModelClass: ContentViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModelClass
    
    init(viewModel: ViewModelClass) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            NavigationView {
                List {
                    ForEach(self.viewModel.pokemons) { pokemon in
                        NavigationLink(destination: PokemonDetail(pokemon: pokemon)) {
                            PokemonCell(pokemon: pokemon)
                                .frame(maxHeight: geometry.size.height / 10)
                        }
                    } // ForEach
                } // List
                .listStyle(GroupedListStyle())
                .navigationBarTitle("Pokemons", displayMode: .automatic)
            } // NavigationView
        }
    }
}

// 4
struct PokemonCell: View {
    
    var pokemon: Pokemon
    
    var body: some View {
        
        HStack {
            Image(uiImage: pokemon.image!)
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
            
            VStack(alignment: .leading) {
                Text(pokemon.name.capitalizingFirstLetter())
                    .font(.headline)
                Text(pokemon.types)
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
        ContentView(viewModel: ContentViewModel())
    }
}

extension String{
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}
