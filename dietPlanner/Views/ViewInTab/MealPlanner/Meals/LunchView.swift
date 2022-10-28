//
//  LunchView.swift
//  dietPlanner
//
//  Created by Aqsa's on 19/09/2022.
//

import SwiftUI

struct LunchItem: Identifiable {
    var id: Int
    var title: String
    var color: Color
    
}

class LunchStore: ObservableObject {
    @Published var items: [LunchItem]
    
    let colors: [Color] = [.red, .orange, .blue, .teal, .mint, .green, .gray, .indigo, .black]

    // dummy data
    init() {
        items = []
        for i in 0...3 {
            let new = LunchItem(id: i, title: "Item \(i)", color: colors[i])
            items.append(new)
        }
    }
}


struct LunchView: View {
    
    @StateObject var store = Store()
    @State private var snappedItem = 0.0
    @State private var draggingItem = 0.0
    
    var body: some View {
        
        ZStack {
            ForEach(store.items) { item in
                VStack(){
                    Image("break")
                        .resizable()
                        
                        .frame(height: 200)
                    HStack {
                        Text("Slice+Egg Breakfast")
                            .font(.custom(Nunito.Medium.rawValue, size: 16))
                        Spacer()
                    }.padding([.horizontal])
                    
                    HStack {
                        Spacer()
                        Button ( action: {  },
                        label: {
                            HStack{
                                Image(systemName: "multiply").foregroundColor(.red)
                                Text("Skip")
                                    .font(.custom(Nunito.Medium.rawValue, size: 16)).foregroundColor(.red)
                            }
                        })
                    
                    
                    Button ( action: {  },
                    label: {
                        HStack{
                            Image(systemName: "checkmark").foregroundColor(.green)
                            Text("done")
                                .font(.custom(Nunito.Medium.rawValue, size: 16)).foregroundColor(.green)
                        }
                    })
                    }.padding()
                    
                    
                }.overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.gray, lineWidth: 0.5)
                    
                )
               
                .scaleEffect(1.0 - abs(distance(item.id)) * 0.2 )
                .opacity(1.0 - abs(distance(item.id)) * 1 )
                .offset(x: myXOffset(item.id), y: 0)
                .zIndex(1.0 - abs(distance(item.id)) * 0.1)
            }
        }
        .gesture(
            DragGesture()
                .onChanged { value in
                    draggingItem = snappedItem + value.translation.width / 100
                }
                .onEnded { value in
                    withAnimation {
                        draggingItem = snappedItem + value.predictedEndTranslation.width / 100
                        draggingItem = round(draggingItem).remainder(dividingBy: Double(store.items.count))
                        snappedItem = draggingItem
                    }
                }
        )
    }
    
    func distance(_ item: Int) -> Double {
        return (draggingItem - Double(item)).remainder(dividingBy: Double(store.items.count))
    }
    
    func myXOffset(_ item: Int) -> Double {
        let angle = Double.pi * 2 / Double(store.items.count) * distance(item)
        return sin(angle) * 200
    }
    
}

struct LunchView_Previews: PreviewProvider {
    static var previews: some View {
        LunchView()
    }
}
