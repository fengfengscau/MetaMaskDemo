//
//  TabItems.swift
//  MetaMaskDemo
//
//  Created by huangminfeng on 2022/7/9.
//

import Foundation

struct TabItem: Identifiable {
    let id = UUID().uuidString
    let title: String
}

let tabItems = [
    TabItem(title: "TOKENS"),
    TabItem(title: "NFTs")
]
