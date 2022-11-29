//
//  DislikeFoodList.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 27/10/2022.
//

import SwiftUI

struct DislikeFoodList: View {
    
    
    @ObservedObject var vm: PreferenceViewModel
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        
    ]
    
    var body: some View {
        loadView()
    }
}

extension DislikeFoodList {
    
    func loadView() -> some View {
        VStack{
            ScrollView(showsIndicators: false) {
                if !vm.dislike_foods.isEmpty {

                    Text("Fruites")
                        .font(Font.custom(Nunito.Bold.rawValue, size: 22))
                    
                    LazyVGrid(columns: columns,spacing: 20) {
                        ForEach((0..<42)) { index in
                            VStack {
                                FoodDislikeItem(dislikeFood: $vm.dislike_foods[index], vm: vm)
                            }
                        }
                    }
                    Text("Vegetables")
                        .font(Font.custom(Nunito.Bold.rawValue, size: 22))
                   
                    LazyVGrid(columns: columns,spacing: 20) {
                        ForEach((42..<80)) { index in
                            VStack {
                                FoodDislikeItem(dislikeFood: $vm.dislike_foods[index], vm: vm)
                            }
                        }
                    }
                    
                    Text("Meats")
                        .font(Font.custom(Nunito.Bold.rawValue, size: 22))
                    
                    LazyVGrid(columns: columns,spacing: 20) {
                        ForEach((80..<99)) { index in
                            VStack {
                                FoodDislikeItem(dislikeFood: $vm.dislike_foods[index], vm: vm)
                            }
                        }
                    }
                    
                }
                
//                LazyVGrid(columns: columns,spacing: 20) {
//                    ForEach($vm.dislike_foods) { dislikeFood in
//                        VStack {
//                            FoodDislikeItem(dislikeFood: dislikeFood, vm: vm)
//                        }
//                    }
//                }
            }

        }.padding()
    }
}

struct DislikeFoodList_Previews: PreviewProvider {
    static var previews: some View {
        DislikeFoodList(vm: PreferenceViewModel())
    }
}
