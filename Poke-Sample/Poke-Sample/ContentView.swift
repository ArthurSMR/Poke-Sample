//
//  ContentView.swift
//  Poke-Sample
//
//  Created by Arthur Rodrigues on 30/06/20.
//  Copyright © 2020 Arthur Rodrigues. All rights reserved.
//

import SwiftUI

let testData = [Pokemon(name: "Pikachu", type: "Elétrico", image: UIImage(named: "pikachu")!),
                Pokemon(name: "Blastoise", type: "Água", image: UIImage(named: "blastoise")!),
                Pokemon(name: "Dito", type: "Terra", image: UIImage(named: "dito")!),
                Pokemon(name: "Poliwag", type: "Água", image: UIImage(named: "poliwag")!)]

struct ContentView: View {
    
    @State var pokemonsList: [Pokemon]
    
    var body: some View {
        
        GeometryReader { geometry in
            NavigationView {
                List {
                    ForEach(self.pokemonsList) { pokemon in
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
            Image(uiImage: pokemon.image)
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
            
            VStack(alignment: .leading) {
                Text(pokemon.name)
                    .font(.headline)
                Text(pokemon.type)
                    .font(.subheadline)
            }
        }
    }
}

struct Pokemon: Identifiable {
    var id = UUID()
    var name: String
    var type: String
    var image: UIImage
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
        ContentView(pokemonsList: testData)
    }
}
