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
        case sucessQuote
        case sucessEpisode
        case faild(error: Error)
    }
    
   private(set) var status: FetchStatus = .notStarted // set is not possible from view class
    
    private let fetcher = FetchService()
    
    var quote: Quote
    var character: Char
    var episode: Episode
    
    init() {
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let qouteData = try! Data(contentsOf: Bundle.main.url(forResource: "samplequote", withExtension: "json")!)
        quote = try! decoder.decode(Quote.self, from: qouteData)
        
        let characterData = try! Data(contentsOf: Bundle.main.url(forResource: "samplecharacter", withExtension: "json")!)
        character = try! decoder.decode(Char.self, from: characterData)
        
        let episodeData = try! Data(contentsOf: Bundle.main.url(forResource: "sampleepisode", withExtension: "json")!)
        episode = try! decoder.decode(Episode.self, from: episodeData)
    }
    
    func getQuoteData(for show: String) async {
        status = .fetching
        
        do {
            quote = try await fetcher.fetchQuote(from: show)
            
            character = try await fetcher.fetchCharacter(quote.character)
            
            character.death = try await fetcher.fetchDeath(for: character.name)
            
            status = .sucessQuote
        }catch{
            status = .faild(error: error)
        }
    }
    
    func getEpisodeData(for show: String) async {
        status = .fetching
        
        do {
            if let unwrappedEpisode = try await fetcher.fetchEpisode(from: show){
                episode = unwrappedEpisode
            }
            status = .sucessEpisode
        }catch{
            status = .faild(error: error)
        }
    }
}
