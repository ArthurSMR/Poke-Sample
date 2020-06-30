//
//  ContentViewModel.swift
//  Poke-Sample
//
//  Created by Lucas Antevere Santana on 30/06/20.
//  Copyright © 2020 Arthur Rodrigues. All rights reserved.
//

import Combine

final class ContentViewModel: ObservableObject {
    
    @Published var pokemons: [Pokemon]?
    
    private var networkingServices:NetWorkingService
    
    private lazy var subscriber = Subscribers.Sink(receiveCompletion: reciveCompletion, receiveValue: reciveValues)
    
    init(netWorkingService:NetWorkingService = NetWorkingService()) {
        networkingServices = netWorkingService
        fetchContent()
    }
    
    func fetchContent() {
        self.fetchPokemons(names: ["ditto","snorlax","charmander","pikachu"])
    }
    
    func fetchPokemons(names:[String]){
        self.networkingServices.getMultiplePokemons(pokemonNames: names).subscribe(subscriber)
    }
    
    private func reciveCompletion(_ completion: Subscribers.Completion<Never>) {
       return
    }
    
    private func reciveValues(_ values:[Pokemon]){
        self.pokemons = values
    }
}
