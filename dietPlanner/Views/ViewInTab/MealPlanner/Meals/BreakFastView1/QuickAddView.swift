//
//  QuickAddView.swift
//  dietPlanner
//
//  Created by Aqsa's on 27/09/2022.
//

import SwiftUI

struct QuickAddView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showPicker = false
    @State private var inputImage: UIImage?
    
    @State var title: String = ""
    @State var text: String = ""
    @State var descrption: String = ""
    var body: some View {
        VStack{
            navBarView().padding([.bottom],50)
        ScrollView(showsIndicators: false){
        VStack {
            VStack(alignment: .leading) {
                Button {
                    showPicker.toggle()
                } label: {
                    if inputImage == nil {
                        ZStack {
                            Image("qorma")
                                .resizable()
                            .frame( height: 100)
                            HStack{
                                Text("+").font(.custom(Nunito.Bold.rawValue, size: 22))
                                    .foregroundColor(.white)
                                Text("Attach a Photo").font(.custom(Nunito.Regular.rawValue, size: 20))
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    else {
                        ZStack {
                            Image(uiImage: inputImage!)
                                .resizable()
                            .frame( height: 100)
                            HStack{
                                Text("+").font(.custom(Nunito.Bold.rawValue, size: 22))
                                    .foregroundColor(.white)
                                Text("Attach a Photo").font(.custom(Nunito.Regular.rawValue, size: 20))
                                    .foregroundColor(.white)
                            }
                        }
                        

                    }

                }
                
            
                          
                   }.sheet(isPresented: $showPicker) {
                       ImagePickerView(sourceType: .photoLibrary) { image in
                           inputImage = image
                       }
                   }
            CustomTextField(placeHolder: "Name", text: $title)
                .background(.white)
                .padding([.vertical],30)
               
            VStack(spacing: 20){
            data("Calories", "155g")
            data("Carbohydrates", "140g")
            data("Proteins", "300g")
            data("Fats", "140g")
        }
            
            TextEditor(text: $text)
                            
                            .textFieldStyle(.roundedBorder)
                            .colorMultiply(.white)
                                .frame( height: 199)
                                .border(.gray, width: 0.5)
                                .cornerRadius(10)
                                .shadow(radius: 1)
                                .foregroundColor(.gray)
                                .padding([.top],30)
            
            addButton()
         
        }
        }
    }.padding()
        
}
}


extension QuickAddView {
    func navBarView() -> some View {
        ZStack {
            HStack{
                Button ( action: { self.presentationMode.wrappedValue.dismiss() },
                label: {
             
                    Image(systemName: "arrow.backward").frame(width: 16, height: 16)
                        .foregroundColor(Color(ColorName.appAqua.rawValue))
                       
                })
            
                Spacer()
                
            }
            
            Text("Quick Add")
                .font(.custom(Nunito.Bold.rawValue, size: 22.5))
                .foregroundColor(Color(ColorName.appAqua.rawValue))
        }
    }
    
    func addButton() -> some View {
            NavigationLink(
                destination: BreakFastView()   .navigationBarTitle("")
                    .navigationBarHidden(true)
            , label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 50)
                        .foregroundColor(Color("btnBlue"))
                Text("Add")
                        .font(.custom("Nunito-Bold", size: 20))
                    .foregroundColor(.white)
                }.padding([.top], 32)
            })
    }
    
    func data(_ name: String, _ amount: String) -> some View {
        ZStack(alignment: .leading) {
            
            RoundedRectangle(cornerRadius: 5)
                .stroke( .gray, lineWidth: 0.5)
              .frame(height: 56)
              
            
            HStack {
                Text(name)
                    .foregroundColor( .gray)
                    .font(.custom(Nunito.Semibold.rawValue, size: 20))
                Spacer()
                Text(amount)
                    .foregroundColor( Color(ColorName.appAqua.rawValue))
                    .font(.custom(Nunito.Semibold.rawValue, size: 20))
            }.padding()
                
        }
    }
}

struct QuickAddView_Previews: PreviewProvider {
    static var previews: some View {
        QuickAddView()
    }
}
