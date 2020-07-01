//
//  NetworkingService.swift
//  Poke-Sample
//
//  Created by Daniel Oliveira on 30/06/20.
//  Copyright © 2020 Arthur Rodrigues. All rights reserved.
//

import Foundation
import Combine

class NetWorkingService {
    
    private var baseURL = URL(string:"https://pokeapi.co/api/v2")!
        
    func getSinglePokemon(pokemonName: String) -> AnyPublisher<Pokemon, Never> {
        
        let pokemonUrl = baseURL.appendingPathComponent("pokemon/\(pokemonName.lowercased())")
       
        return URLSession.shared.dataTaskPublisher(for: pokemonUrl)
            .map {$0.data}
            .decode(type: Pokemon.self, decoder: JSONDecoder())
            .breakpointOnError()
            .replaceError(with: Pokemon())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getMultiplePokemons(pokemonNames:[String])->AnyPublisher<[Pokemon], Never>{
        
        var pokemonsPublishers = [AnyPublisher<Pokemon,Never>]()
        
        pokemonNames.forEach { (pokemonName) in
            
            let pokemonURL = baseURL.appendingPathComponent("pokemon/\(pokemonName)")

            let publisher = URLSession.shared.dataTaskPublisher(for: pokemonURL)
                .map {$0.data}
                .decode(type: Pokemon.self, decoder: JSONDecoder())
                .breakpointOnError()
                .replaceError(with: Pokemon())
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
            
            pokemonsPublishers.append(publisher)
           
        }
        
        return Publishers.MergeMany(pokemonsPublishers)
            .collect() // retorna em um vetor de pokemons
            .eraseToAnyPublisher()
    }
}
