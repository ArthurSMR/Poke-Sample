//
//  NetworkingService.swift
//  Poke-Sample
//
//  Created by Daniel Oliveira on 30/06/20.
//  Copyright © 2020 Arthur Rodrigues. All rights reserved.
//

import Foundation
import Combine

class NetWorkingService{
    
    private var baseURL = URL(string:"https://pokeapi.co/api/v2")!
    
    func getPokemon<T:Decodable>(pokemonName:String) -> AnyPublisher<T,Error>{
        
        let pokemonUrl = baseURL.appendingPathComponent("pokemon/\(pokemonName)")
       
        return URLSession.shared.dataTaskPublisher(for: pokemonUrl)
            .map {$0.data}
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            
    }
    
}
