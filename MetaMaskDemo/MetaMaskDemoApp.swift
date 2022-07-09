//
//  MetaMaskDemoApp.swift
//  MetaMaskDemo
//
//  Created by huangminfeng on 2022/7/9.
//

import SwiftUI

@main
struct MetaMaskDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(jsonData()) // Creating an instance of jsonData that we pass to the content view
        }
    }
}
