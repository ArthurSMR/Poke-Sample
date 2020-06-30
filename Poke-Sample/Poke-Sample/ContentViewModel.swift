//
//  ContentViewModel.swift
//  Poke-Sample
//
//  Created by Lucas Antevere Santana on 30/06/20.
//  Copyright © 2020 Arthur Rodrigues. All rights reserved.
//

import Combine

final class ContentViewModel: ObservableObject {
    
    @Published var pokemon: Pokemon?
    
    private var networkingServices = NetWorkingService()
    
    private lazy var subscriber = Subscribers.Sink(receiveCompletion: reciveCompletion, receiveValue: reciveValue)
    
    init() {
       fetchContent()
    }
    
    func fetchContent() {
        self.fetchPokemon(name: "ditto")
    }
    
    func fetchPokemon(name: String) {
        self.networkingServices.getPokemon(pokemonName: name).subscribe(subscriber)
    }
    
    private func reciveCompletion(_ completion: Subscribers.Completion<Never>) {
       return
    }
    
    private func reciveValue(_ value: Pokemon) {
        self.pokemon = value
    }
}
