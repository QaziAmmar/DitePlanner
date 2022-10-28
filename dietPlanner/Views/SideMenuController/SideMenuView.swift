//
//  SideMenuView.swift
//  Insurtech
//
//  Created by Taimoor Arif on 07/05/2022.
//

import SwiftUI
import simd
import SDWebImageSwiftUI

struct SideMenuView: View {

    let menuClose: () -> Void
    var onClick: (_ selectedView: NavViews) -> Void

    var body: some View {
        ZStack {

                HStack {
                    VStack(alignment: .trailing, spacing: 20) {

                        Button {
                            self.menuClose()
                        } label: {
                            Image(systemName: "multiply")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 12, height: 12)
                                .padding()
                                .foregroundColor(.black)
                        }.padding(.top, 60)
                        
                        VStack(spacing: 0) {
                            
                            profileView()
                            
                            sideMenuSystemBtn(with: "Preferences", icon: "calendar", navView: .preferences)
                            sideMenuSystemBtn(with: "Edit Profile", icon: "chart.bar.fill", navView: .edit_profile)
                            sideMenuSystemBtn(with: "Change Password", icon: "info.circle.fill", navView: .change_password)
                            sideMenuSystemBtn(with: "Calorie & Macro Goals", icon: "gearshape.fill", navView: .goals)
                        }
                        
                        Spacer()

                        HStack{
                            Button {
                                onClick(.logout)
                            } label: {
                                Text("Logout")
                                    .font(Font.custom(Nunito.Regular.rawValue, size: 20))
                                    .padding()
                                    .foregroundColor(.red)
                            }
                            
                            Text("App Version - V2.00")
                                .font(Font.custom(Nunito.Regular.rawValue, size: 14))
                            Spacer()
                        }
                        
                    }

                    .background(RoundedRectangle(cornerRadius: 1)
                        .foregroundColor(Color(ColorName.appPale.rawValue))
                        .cornerRadius(30, corners: [.topRight, .bottomRight]))
              Spacer()

                }

        }.edgesIgnoringSafeArea(.top)


    }
}
//
//// MARK: UIView Extension
extension SideMenuView {

    func sideMenuSystemBtn(with name: String, icon: String, navView: NavViews) -> some View {
        Button {
            onClick(navView)
        } label: {
            HStack {
                
                Text(name)
                    .font(Font.custom(Nunito.Medium.rawValue, size: 14))
                Spacer()
                Image(systemName: "chevron.forward")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 14, height: 14)
            }.foregroundColor(Color(ColorName.appGray.rawValue))
        }
        .padding(15)
    }
    
    
    func profileView() -> some View {
        HStack {

            WebImage(url: URL(string: UserDefaultManager.shared.img_url))
                                    .resizable()
                                    .placeholder(Image("GenricPlaceHolder"))
                                    .indicator(.activity)
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())

            Text(UserDefaultManager.shared.userName)
                .font(Font.custom(Nunito.Bold.rawValue, size: 14))
            Spacer()
        }
        .padding()
        
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(menuClose: {print("close menu")}, onClick: {viewName in
            print(viewName)
        })
    }
}

