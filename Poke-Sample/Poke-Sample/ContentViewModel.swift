//
//  ContentViewModel.swift
//  Poke-Sample
//
//  Created by Lucas Antevere Santana on 30/06/20.
//  Copyright © 2020 Arthur Rodrigues. All rights reserved.
//

import Combine

protocol ContentViewModelProtocol: ObservableObject {

    var pokemons: [Pokemon] {get}
}

final class ContentViewModel: ContentViewModelProtocol {
        
    @Published var pokemons: [Pokemon]
    
    private var networkingServices: NetWorkingService
    
    private lazy var subscriber = Subscribers.Sink(receiveCompletion: reciveCompletion, receiveValue: reciveValues)
    
    init(netWorkingService: NetWorkingService = NetWorkingService()) {
        pokemons = []
        networkingServices = netWorkingService
        fetchContent()
    }
    
    func fetchContent() {
        self.fetchPokemons(names: ["chikorita","cyndaquil","charmander","pikachu","bulbasaur","squirtle","chimchar","totodile","treecko",
                                   "mudkip","turtwig","piplup"])
    }
    
    func fetchPokemons(names:[String]){
        self.networkingServices.getMultiplePokemons(pokemonNames: names).subscribe(subscriber)
    }
    
    private func reciveCompletion(_ completion: Subscribers.Completion<Never>) {
       return
    }
    
    private func reciveValues(_ values: [Pokemon]){
        self.pokemons = values.sorted(by: {$0.name < $1.name})
    }
}
