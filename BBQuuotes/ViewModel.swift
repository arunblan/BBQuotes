//
//  ViewModel.swift
//  BBQuuotes
//
//  Created by Arun  on 10/03/25.
//

import Foundation

@Observable
@MainActor
class ViewModel{
    enum FetchStatus{
        case notStarted
        case fetching
        case sucess
        case faild(error: Error)
    }
    
   private(set) var status: FetchStatus = .notStarted // set is not possible from view class
    
    private let fetcher = FetchService()
    
    var quote: Quote
    var character: Char
    
    init() {
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let qouteData = try! Data(contentsOf: Bundle.main.url(forResource: "samplequote", withExtension: "json")!)
        quote = try! decoder.decode(Quote.self, from: qouteData)
        
        let characterData = try! Data(contentsOf: Bundle.main.url(forResource: "samplecharacter", withExtension: "json")!)
        character = try! decoder.decode(Char.self, from: characterData)
    }
    
    func getData(for show: String) async {
        status = .fetching
        
        do {
            quote = try await fetcher.fetchQuote(from: show)
            
            character = try await fetcher.fetchCharacter(quote.character)
            
            character.death = try await fetcher.fetchDeath(for: character.name)
            
            status = .sucess
        }catch{
            status = .faild(error: error)
        }
    }
}
