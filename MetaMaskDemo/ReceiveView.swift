//
//  ReceiveView.swift
//  MetaMaskDemo
//
//  Created by huangminfeng on 2022/7/9.
//

import SwiftUI

struct ReceiveView: View {
    private let sheetHeight: CGFloat = 480
    private let sheetWidth: CGFloat = UIScreen.main.bounds.width
    private let sheetCornerRadius: CGFloat = 10
    private let backgroundOpacity = 0.65
    private let dragIndicatorVerticalPadding: CGFloat = 10
    @State private var offset = CGSize.zero
    @Binding var display: Bool
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if display {
                background
                sheet
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    private var background: some View {
        Color.black
            .fillParent()
            .opacity(backgroundOpacity)
            .animation(.spring())
    }
    
    private var sheet: some View {
        VStack {
            indicator
            ReceiveContentView()
        }
        .frame(width: sheetWidth, height: sheetHeight, alignment: .top)
        .background(Color.white)
        .cornerRadius(sheetCornerRadius)
        .offset(y: offset.height)
        .gesture(
            DragGesture()
                .onChanged { value in self.onChangedDragValueGesture(value) }
                .onEnded { value in self.onEndedDragValueGesture(value) }
        )
        .transition(.move(edge: .bottom))
    }
    
    private var indicator: some View {
        DragIndicator()
            .padding(.vertical, dragIndicatorVerticalPadding)
    }
    
    private func onChangedDragValueGesture(_ value: DragGesture.Value) {
        guard value.translation.height > 0 else { return }
        self.offset = value.translation
    }
    
    private func onEndedDragValueGesture(_ value: DragGesture.Value) {
        guard value.translation.height >= self.sheetHeight / 2 else {
            self.offset = CGSize.zero
            return
        }
        
        withAnimation {
            self.display.toggle()
            self.offset = CGSize.zero
        }
    }
}

struct DragIndicator: View {
    private let width: CGFloat = 60
    private let height: CGFloat = 6
    private let cornerRadius: CGFloat = 4
    
    var body: some View {
        Rectangle()
            .fill(.gray)
            .frame(width: width, height: height)
            .cornerRadius(cornerRadius)
    }
}

struct ReceiveContentView: View {
    var body: some View {
        VStack(spacing:12){
            Divider()
            
            Text("Receive")
                .font(.title3)
                .foregroundColor(.black)
            
            Image(systemName: "qrcode")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 210, height: 210, alignment: .center)
            
            Text("Scan address to receive payment")
                .font(.system(size: 14))
                .foregroundColor(.black)
            
            HStack(spacing: 10) {
                Text("0xF83F...6615")
                    .font(.system(size: 16))
                
                Text("Copy")
                    .font(.system(size: 14))
                    .frame(width: 50, height: 24, alignment: .center)
                    .background(Capsule().fill(Color.gray.opacity(0.4)))
                
                Image(systemName: "arrow.up.right")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 12, height: 12, alignment: .center)
            }
            .frame(width: 220, height: 40, alignment: .center)
            .background(Capsule().fill(Color.gray.opacity(0.1)))
            
            HStack(spacing: 20) {
                Button {
                    
                } label: {
                    Text("Buy")
                        .font(.system(size: 16))
                        .frame(width: 160, height: 46, alignment: .center)
                        .foregroundColor(.white)
                        .background(Capsule().fill(Color.accentColor))
                }
                
                Button {
                    
                } label: {
                    Text("Request Payment")
                        .font(.system(size: 16))
                        .frame(width: 160, height: 46, alignment: .center)
                        .foregroundColor(.accentColor)
                        .background(Capsule().stroke(Color.accentColor, lineWidth: 1))
                }
            }
        }
    }
}

public extension View {
    func fillParent(alignment: Alignment = .center) -> some View {
        self
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: alignment
            )
    }
}
