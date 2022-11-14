//
//  AYCleander.swift
//  AYorndaSwiftUI
//
//  Created by Qazi Mudasir on 17/07/2020.
//  Copyright © 2020 Qazi Mudasir. All rights reserved.
//

import SwiftUI


struct MyCalendarY: UIViewControllerRepresentable {
    
    private let onDatePicked: (Date) -> Void
    
    init(onDatePicked : @escaping (Date) -> Void){
        self.onDatePicked = onDatePicked
    }
    
    func makeUIViewController(context: Context) -> AYHorindarViewController {
        
        let horindarViewController: AYHorindarViewController = AYHorindarViewController()//.init()
        
        horindarViewController.delegate = context.coordinator
        horindarViewController.dataSource = context.coordinator
        horindarViewController.uiDelegate = context.coordinator
        
        return horindarViewController
    }
    func updateUIViewController(_ calendar: AYHorindarViewController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, onDatePicked: onDatePicked)
    }
    
    class Coordinator: NSObject  {
        
        var control: MyCalendarY
        private let onDatePicked: (Date) -> Void
        private var firstTime = true
        
        init(_ control: MyCalendarY , onDatePicked: @escaping (Date) -> Void) {
            self.control = control
            self.onDatePicked  = onDatePicked
        }
    }
}
//MARK: AYHorindarDelegate
extension MyCalendarY.Coordinator :  AYHorindarDelegate{
    func current(date: Date) {
        
        if   firstTime == true {
            firstTime  = false
            onDatePicked(date)
        }
    }
    
    func moveSingleItem(date : Date){
        onDatePicked(date)
    }
    
    func moveMultipleItems(date : Date){
        onDatePicked(date)
    }
    
}
//MARK: AYHorindarDataSource
extension MyCalendarY.Coordinator :  AYHorindarDataSource{
    
    func dateFrom() -> Date {
        var components = DateComponents()
        components.year = -5
        return Calendar.current.date(byAdding: components, to: Date.init())!
    }
    
    func dateTo() -> Date {
        var components = DateComponents()
        components.year = 5
        return Calendar.current.date(byAdding: components, to: Date.init())!
    }
    
    func weekdayNameDisplayType() -> AYNameDisplayType {
        return .short
    }
}
//MARK: AYHorindarUIDelegate
extension MyCalendarY.Coordinator :  AYHorindarUIDelegate{
    func contentInsets() -> UIEdgeInsets {
        let inset = UIEdgeInsets(top: -10, left: 20, bottom: -2, right: 2)
        return inset
    }
    
    func spacing() -> CGFloat {
        return 5
    }
    
    func selectedDate() -> Date{
        return Date()
    }

    func topLabelTextColor() -> UIColor {
        return .gray
    }

    func bottomLabelTextColor() -> UIColor {
        return .gray
    }
    
    func topLabelSelectedTextColor() -> UIColor {
        return .white
    }
    func bottomLabelSelectedTextColor() -> UIColor {
        return .white
    }
    func backgorundColor() -> UIColor {
        return .white
    }
    func viewSelectedColor() -> UIColor {
        return UIColor(patternImage: UIImage(named: "gradient_img")!)
    }
    func viewColor() -> UIColor{
        .white
    }
}




extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
