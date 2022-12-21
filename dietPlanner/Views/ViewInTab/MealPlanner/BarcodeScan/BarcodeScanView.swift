//
//  BarcodeScanView.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 29/11/2022.
//

import SwiftUI
import CarBode

struct BarcodeScanView: View {
    
    
//    var onProductFound: (String) -> Void
    
//    @Binding var productId: String
    @AppStorage("productID") private var productId: String = ""
    @Environment(\.presentationMode) private var presentationMode
    @State var rotate = CBBarcodeView.Orientation.up
    
    var body: some View {
        GeometryReader { geometry in
            
            ZStack {
                CBScanner(supportBarcode: .constant([.code128, .code93, .code39, .codabar, .dataMatrix, .ean8, .ean13, .itf14, .upce, .pdf417, .aztec]), //Set type of barcode you want to scan
                    scanInterval: .constant(1.0)  //Event will trigger every 5 seconds
                          
                ){
                    //When the scanner found a barcode
//                    print("BarCodeType =",$0.type.rawValue, "Value =",$0.value)
                    
                    productId = $0.value
                    presentationMode.wrappedValue.dismiss()
                }
                
                
                
                ZStack {
                    Rectangle()
                        .foregroundColor(.black.opacity(0.3))
                        .edgesIgnoringSafeArea(.top)
                    
                    
                    VStack {
                        
                        Spacer()
                        Rectangle()
                            .cornerRadius(20)
                            .frame(width: geometry.size.width - 100, height: geometry.size.height / 3)
                            .blendMode(.destinationOut)
                            .overlay {
                                Image(systemName: "magnifyingglass")
                                    .resizable()
                                    .foregroundColor(.white)
                                    .frame(width: 24, height: 24)
                            }
                        
                        Spacer()
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.black.opacity(0.7))
                                .padding()
                            
                            
                            VStack {
                                Image("Logo")
                                    .resizable()
                                    .cornerRadius(10)
                                    .frame(width: 50, height: 50)
                                    .aspectRatio(contentMode: .fit)
                                    .padding(.top, 50)
                                
                                
                                Text("Welcome to")
                                    .foregroundColor(.white)
                                    .font(.system(size: 40, weight: .bold))
                                Text("Fit Me Food App")
                                    .foregroundColor(.white)
                                    .font(.system(size: 40, weight: .bold))
                                
                                Text("If did't work try to scan barcode horizontally")
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(.white)
                                    .padding([.top, .bottom])

                                Spacer()
                            }
                            
                        }.frame(height: geometry.size.height * 0.4)

                        
                    }

                }.compositingGroup()
            }
        }
    }
}

struct BarcodeScanView_Previews: PreviewProvider {
    static var previews: some View {
        BarcodeScanView()
    }
}
