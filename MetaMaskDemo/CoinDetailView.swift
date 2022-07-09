//
//  CoinDetailView.swift
//  MetaMaskDemo
//
//  Created by huangminfeng on 2022/7/9.
//

import SwiftUI

struct CoinDetailView: View {
    @State var item: CoinItem
    @State private var showReceiveSheet = false
    var body: some View {
        ZStack {
            VStack(spacing: 24) {
                CoinDetailTopNavigationView(item: item)
                CoinDetailPortraitView(item: item)
                CoinDetailMenuItemsView(showReceiveSheet:$showReceiveSheet)
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 1.5)
                    .padding(.horizontal, 50)
                
                Text("You have no transactions!")
                    .foregroundColor(Color.gray)
                    .padding(.top, 50)
                Spacer()
            }
            
            ReceiveView(display: $showReceiveSheet)
            
            
        }.navigationBarHidden(true)
    }
}

struct CoinDetailTopNavigationView: View {
    var item: CoinItem
   
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            HStack {
                Button  {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title)
                }
                
                Spacer()
                
                VStack(spacing: 4) {
                    Text(item.name)
                        .font(.title2)
                        .fontWeight(.light)
                    
                    Text("Binance Smart Chain Mainnet")
                        .font(.callout)
                        .fontWeight(.light)
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
            
            
            .padding(.horizontal)
        }
    }
}

struct CoinDetailPortraitView: View {
    
    var item: CoinItem
    var body: some View {
        VStack(spacing: 8) {
            Button {
                
            } label: {
                Image(item.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50, alignment: .center)
                    .clipShape(Circle())
                    .padding(4)
            }
            
            Text(String(format: "%.2f \(item.name)", item.amount))
                .font(.title)
            
            Text(item.dollar)
                .foregroundColor(.gray)
        }
    }
}

struct CoinDetailMenuItemsView: View {
   
    @Binding var showReceiveSheet: Bool
    
    var body: some View {
        HStack(alignment: VerticalAlignment.center, spacing: 8) {
            ForEach(menuItems) { item in
                VStack {
                    Button {
                        if item.title == "Receive" {
                            withAnimation {
                                showReceiveSheet.toggle()
                            }
                        }
                    } label: {
                        VStack {
                            Circle()
                                .fill(Color.accentColor)
                                .frame(width: 35, height: 35, alignment: .center)
                                .overlay(
                                    Image(systemName: item.image)
                                        .foregroundColor(.white)
                                )
                            
                            Text(item.title)
                                .foregroundColor(Color.accentColor)
                                .fontWeight(.medium)
                        }
                        .frame(width: 70)
                    }
                }
            }
        }
    }
}
