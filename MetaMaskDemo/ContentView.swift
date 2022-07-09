//
//  ContentView.swift
//  MetaMaskDemo
//
//  Created by huangminfeng on 2022/7/9.
//

import SwiftUI

struct ContentView: View {
    @State var currentIndex: Int = 0
    @State private var showReceiveSheet = false
    
    var body: some View {
        ZStack {
            NavigationView {
                
                VStack(spacing: 24) {
                    TopNavigationView() // TOP  NavigationView
                    HeadPortraitView() // The User Icon And Name
                    MenuViewView(showReceiveSheet:$showReceiveSheet) // The 4 Action Buttons
                    BottomTabView() // Tokens And NFTs
                    Spacer().navigationBarHidden(true)
                }
            }
            
            //Receive View is hide when page load
            ReceiveView(display: $showReceiveSheet)
        }
        
    }
}


struct TopNavigationView: View {
    var body: some View {
        VStack {
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: "line.horizontal.3") // left menu button
                        .font(.title)
                }
                
                Spacer()
                
                VStack(spacing: 4) {
                    Text("Wallet") //navigation title
                        .font(.title)
                        .fontWeight(.light)
                    
                    HStack {
                        Circle()
                            .fill(Color.green)
                            .frame(width: 8, height: 8)
                        
                        Text("Etherem Main Network")
                            .font(.callout)
                            .fontWeight(.light)
                            .foregroundColor(.gray)
                    }
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "qrcode.viewfinder")
                        .font(.title)
                }
            }
            .padding(.horizontal)
            
            Divider()
        }
    }
}

// USER Info
struct HeadPortraitView: View {
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.center, spacing: 8) {
            Button {
                
            } label: {
                Image("avatar")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50, alignment: .center)
                    .clipShape(Circle())
                    .padding(4)
                    .background(Circle().stroke(Color.accentColor, lineWidth: 3))
            }
            
            Text("Account 1")
                .font(.title)
            
            Text("$1,000,000.00")
                .foregroundColor(.gray)
            
            Text("0xF83F...d662")
                .font(.callout)
                .foregroundColor(.gray)
                .padding(.horizontal, 20)
                .padding(.vertical, 8)
                .background(Capsule().fill(Color.blue.opacity(0.1)))
        }
    }
}

// Receive , Buy, Send , Swap Button
struct MenuViewView:View {
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
                                .frame(width: 30, height: 30, alignment: .center)
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

// Tokens and NFTs
struct BottomTabView: View {
    
    @State var selectedIndex: Int = 0
    @Namespace var animation
    @EnvironmentObject var jsonData: jsonData
    
    var body:some View {
        VStack(spacing:0) {
            HStack {
                ForEach(0 ..< tabItems.count) { i in
                    VStack {
                        Text(tabItems[i].title)
                            .foregroundColor(selectedIndex == i ? Color.accentColor : .gray)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                        
                        if selectedIndex == i {
                            Rectangle()
                                .fill(Color.accentColor)
                                .frame(height: 3)
                                .matchedGeometryEffect(id: "tab", in: animation)
                        } else {
                            Rectangle()
                                .fill(Color.clear)
                                .frame(height: 3)
                        }
                        
                    }
                    .onTapGesture {
                        withAnimation {
                            selectedIndex = i
                        }
                    }
                }
            }
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(height: 1.5)
            
            TabView(selection: $selectedIndex) {
                TokenView()
                    .tag(0)
                NFTView()
                    .tag(1)
            }
            .tabViewStyle(
                PageTabViewStyle(indexDisplayMode: .never)
            )
        }
    }
}

struct TokenView: View {
    @EnvironmentObject var jsonData: jsonData
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                ForEach(jsonData.jsonArray) { coin in
                    NavigationLink(destination: CoinDetailView(item: coin)) { // Jump to coin detail
                        VStack {
                            HStack(spacing: 15) {
                                Image(coin.image)
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                                
                                VStack(alignment: .leading) {
                                    Text("\(coin.amount) \(coin.name)")
                                        .font(.system(size: 16))
                                        .fontWeight(.medium)
                                        .foregroundColor(.black)
                                    Text(coin.dollar)
                                        .font(.system(size: 12))
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                            }
                            .padding(.horizontal)
                            
                            Divider()
                        }
                    }
                }
                .padding(.top)
                
                VStack(spacing: 8) {
                    Text("Don't see your token?")
                        .foregroundColor(.gray)
                        .font(.title3)
                    
                    Button {
                        
                    } label: {
                        Text("Import Tokens")
                    }
                }
                .padding(.top)
            }
            .padding(.top, 10)
        }
        
    }
}

struct NFTView: View {
    var body: some View {
        VStack {
            Image("space")
                .resizable()
                .frame(width: 40, height: 40)
                .padding(8)
                .background(Circle().stroke(Color.gray.opacity(0.6), lineWidth: 5))
                .padding(.bottom, 18)
            Text("No NFTs yet")
                .font(.title2)
            
            Button {
                
            } label: {
                Text("Learn More")
                    .foregroundColor(Color.accentColor)
            }
        }
        .foregroundColor(Color.gray.opacity(0.6))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
