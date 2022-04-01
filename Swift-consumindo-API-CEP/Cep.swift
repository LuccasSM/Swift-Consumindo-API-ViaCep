//
//  Cep.swift
//  Swift-consumindo-API-CEP
//
//  Created by Luccas Santana Marinho on 31/03/22.
//

import Foundation

struct Cep: Decodable {
    var logradouro: String
    var bairro: String
    var localidade: String
    var uf: String
    var ddd: String
}
