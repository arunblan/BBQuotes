//
//  CharacterView.swift
//  BBQuuotes
//
//  Created by Arun  on 07/03/25.
//

import SwiftUI

struct CharacterView: View {

    let character: Char
    let show: String

    var body: some View {
        GeometryReader{ geometry in
            
            ZStack(alignment: .top) {
                Image(show.lowercased().replacingOccurrences(of: " ", with: ""))
                    .resizable()
                    .scaledToFit()
                
                
                ScrollView{
                    AsyncImage(url: character.images[0]) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                
                .frame(width: geometry.size.width / 1.2, height: geometry.size.height / 1.7)
                .clipShape(.rect(cornerRadius: 25))
                .padding(.top, 60)
                    
                    VStack(alignment: .leading){
                        Text(character.name)
                            .font(.largeTitle)
                        
                        Text("Protayed By: \(character.portrayedBy)")
                            .font(.title2)
                        
                        Divider()
                        
                        Text("\(character.name) Character Info")
                        
                        Divider()
                        
                        Text("Born By: \(character.birthday)")
                        
                        Divider()
                        
                        ForEach(character.occupations, id: \.self ) { occupations in
                            
                            Text("•\(occupations)")
                                .font(.subheadline)
                            
                        }
                            
                        Divider()
                        
                        Text("Nick Names: ")
                        
                        if character.aliases.count > 0 {
                            ForEach(character.aliases, id: \.self ) { aliases in
                                
                                Text("•\(aliases)")
                                    .font(.subheadline)
                                
                            }
                            
                        }else{
                            Text("None")
                        }
                        
                        Divider()
                        
                        DisclosureGroup("Status (spoiler alert!):"){
                            VStack(alignment: .leading){
                                Text(character.status)
                                    .font(.title2)
                                
                                if let death = character.death{
                                    AsyncImage(url: death.image) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(.rect(cornerRadius: 15))
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    
                                    Text("How: \(death.details)")
                                        .padding(.bottom)
                                    
                                    Text("Last words: \"\(death.lastWords)\"")
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .tint(.primary)
                    }
                    .frame(width: geometry.size.width / 1.25, alignment: .leading)
                    .padding(.bottom, 50)
                }
                .scrollIndicators(.hidden)
            }
        }        .ignoresSafeArea()

    }
}

#Preview {
    CharacterView(character: ViewModel().character, show: "Breaking Bad")
        .preferredColorScheme(.dark)
}
