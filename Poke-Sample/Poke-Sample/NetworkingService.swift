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
    
    /// Base endpoint of the API
    private var baseURL = URL(string:"https://pokeapi.co/api/v2")!
        
    func getSinglePokemon(pokemonName: String) -> AnyPublisher<Pokemon, Never> {
        
        /// Endpoint of the pokemon name
        let pokemonUrl = baseURL.appendingPathComponent("pokemon/\(pokemonName.lowercased())")
       
        return URLSession.shared.dataTaskPublisher(for: pokemonUrl) // Publisher of the url session
            .map {$0.data} // Transform the output of the previous publisher -> get only the data of the request
            .decode(type: Pokemon.self, decoder: JSONDecoder()) // Decode de data to the generic type = Data -> Pokemon
            .breakpointOnError() // debug
            .replaceError(with: Pokemon()) // If has error in proccess decoding, replacing with a empty Pokemon object
            .receive(on: DispatchQueue.main) // Ensure to receive the in the main thread to update the ui
            .eraseToAnyPublisher() // Transform the to generic publisher
    }
    
    func getMultiplePokemons(pokemonNames:[String])->AnyPublisher<[Pokemon], Never>{
        
        /// Array of the publishers off the requests
        var pokemonsPublishers = [AnyPublisher<Pokemon,Never>]()
        
        pokemonNames.forEach { (pokemonName) in
            
            /// Endpoint of the pokemon name
            let pokemonURL = baseURL.appendingPathComponent("pokemon/\(pokemonName)")

            let publisher = URLSession.shared.dataTaskPublisher(for: pokemonURL) // Publisher of the url session
                .map {$0.data} // Transform the output of the previous publisher -> get only the data of the request
                .decode(type: Pokemon.self, decoder: JSONDecoder()) // Decode de data to the generic type = Data -> Pokemon
                .breakpointOnError() // debug
                .replaceError(with: Pokemon()) // If has error in proccess decoding, replacing with a empty Pokemon object
                .receive(on: DispatchQueue.main) // Ensure to receive the in the main thread to update the ui
                .eraseToAnyPublisher() // Transform the to generic publisher
            
            pokemonsPublishers.append(publisher)
           
        }
        
        return Publishers.MergeMany(pokemonsPublishers) // Group all the publishers to one
            .collect() // Group all thes outputs in a single array
            .eraseToAnyPublisher() // Transform the to generic publisher
    }
}
