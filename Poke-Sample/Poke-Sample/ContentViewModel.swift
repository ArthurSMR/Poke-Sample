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
    
    var disposables = Set<AnyCancellable>()
    
    init() {
       fetchContent()
    }
    
    func fetchContent() {
        
    }
}
