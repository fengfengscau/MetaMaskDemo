//
//  CoinItem.swift
//  MetaMaskDemo
//
//  Created by huangminfeng on 2022/7/9.
//

import Foundation
struct CoinItem: Hashable, Codable, Identifiable {
    var id: String
    var image: String
    let amount: Double
    var name: String
    var dollar: String
}

