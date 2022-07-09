//
//  jsonData.swift
//  MetaMaskDemo
//
//  Created by huangminfeng on 2022/7/9.
//

import Foundation

// Heres the struct I used to model the data
struct jsonModel: Hashable, Codable, Identifiable {
    var id: UUID
    var valueOne: String
    var valueTwo: String
}
