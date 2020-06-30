//
//  PokemonDetail.swift
//  Poke-Sample
//
//  Created by Arthur Rodrigues on 30/06/20.
//  Copyright © 2020 Arthur Rodrigues. All rights reserved.
//

import SwiftUI

struct PokemonDetail: View {
    var body: some View {
        
        VStack(alignment: .center, spacing: 8) {
            Image("pikachu")
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
            Text("Pikachu")
                .font(.title)
            Text("Elétrico")
            Text("São Paulo")
            Spacer()
        } // VStack
    }
}

/*
 Etapas:
 
 1- VStack com infos do pokemon (imagem/nome/tipo/loc)
 2- Arrumar tamanho da imagem (resizeble/aspect ratio)
 3- Colocar o spacer para subir
 4- Alinhar VStack p/ center com spacing 8
 */

struct PokemonDetail_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetail()
    }
}
