//
//  QuoteManager.swift
//  HTPlanner
//
//  Created by Qazi Ammar Arshad on 06/06/2022.
//

import Foundation

class QuoteManager {
    
    static let shared = QuoteManager()
    var quotes = [String]()
    
    init() {
        if let localData = self.readLocalFile(forName: "quotes") {
            self.parse(jsonData: localData)
        }
    }
    
    /// this function will read the json file for locally
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    private func parse(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode(QuoteModel.self,
                from: jsonData)
            quotes = decodedData.quotes
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    public func getQuoteOfTheDay() -> String {
    
        let quotesNumber = DateManager.standard.getDayOfTheYear()
        let quote_array = String(quotes[quotesNumber].dropFirst(3)).components(separatedBy: "-")
        let quote = quote_array.first
        return quote ?? "-"
        
    }
    
    public func getQuoteAndAuthorOfTheDay() -> (String, String) {
    
        let quotesNumber = DateManager.standard.getDayOfTheYear()
        let quote_array = String(quotes[quotesNumber].dropFirst(3)).components(separatedBy: "-")
        let quote = quote_array.first ?? "-"
        let author = quote_array.count > 1 ? quote_array[1] ?? "-" : "_"
        return (quote, author)
        
    }
    
    public func getAuthor() -> String {
    
        let quotesNumber = DateManager.standard.getDayOfTheYear()
        let quote_array = String(quotes[quotesNumber].dropFirst(3)).components(separatedBy: "-")
        let quote = quote_array.count > 1 ? quote_array[1] : "_"
        return quote ?? "-"
        
    }
    
}
