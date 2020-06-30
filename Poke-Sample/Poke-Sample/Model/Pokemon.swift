//
//  Pokemon.swift
//  Poke-Sample
//
//  Created by Lucas Antevere Santana on 30/06/20.
//  Copyright © 2020 Arthur Rodrigues. All rights reserved.
//

import Foundation
import UIKit

struct Pokemon: Decodable {
    
    let name: String
    let image: UIImage?
    let types: String
    let location: String
    
    enum PokemonKeys: String, CodingKey {
        case name
        case sprites
        case type
        case locationAreaEncounters = "location_area_encounters"
    }
    
    enum SpritesKeys: String, CodingKey {
        case backDefault
    }
    
    private struct TypeElement: Codable {
        let slot: Int
        let type: Species
    }
    
    private struct Species: Codable {
        let name: String
        let url: String
    }
    
    init(from decoder: Decoder) throws {
        
        let mainContainer = try decoder.container(keyedBy: PokemonKeys.self)
        
        self.name = try mainContainer.decode(String.self, forKey: .name)
        self.location = try mainContainer.decode(String.self, forKey: .locationAreaEncounters)
        
        let spritesContainer = try mainContainer.nestedContainer(keyedBy: SpritesKeys.self, forKey: .sprites)
        
        let url = try spritesContainer.decode(URL.self, forKey: .backDefault)
              
        self.image = try UIImage(data: Data(contentsOf: url))
            
        let typesContent = try mainContainer.decode([TypeElement].self, forKey: .type)
        
        self.types = typesContent.reduce("", { (result, element) -> String in
            
            if result == "" {
                return element.type.name.capitalized
                
            } else {
                return result + ", " + element.type.name.capitalized
            }
        })
    }
}
