//
//  QuoteView.swift
//  BBQuuotes
//
//  Created by Arun  on 07/03/25.
//

import SwiftUI

struct FetchView: View {
    
    let vm = ViewModel()
    let show: String
    
    @State var showCharacterInfo = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                Image(show.removeCaseAndSpace())
                    .resizable()
                    .frame(width: geometry.size.width * 2.7, height: geometry.size.height * 1.2)
                
                VStack{
                    VStack{
                        Spacer(minLength: 60)
                        switch vm.status {
                        case .notStarted:
                            EmptyView()
                        case .fetching:
                            ProgressView()
                        case .sucessQuote:
                            Text("\"\(vm.quote.quote)\"")
                                .minimumScaleFactor(0.5)
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.white)
                                .padding()
                                .background(.black.opacity(0.5))
                                .clipShape(.rect(cornerRadius: 25))
                                .padding(.horizontal)
                            
                            ZStack(alignment: .bottom){
                                AsyncImage(url: vm.character.images[0]) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                }
                                Text(vm.quote.character)
                                    .foregroundStyle(.white)
                                    .padding(10)
                                    .frame(maxWidth: .infinity)
                                    .background(.ultraThinMaterial)
                                    .padding(.bottom, 18)
                            }
                            .frame(width: geometry.size.width / 1.1, height: geometry.size.height / 1.8)
                            .clipShape(.rect(cornerRadius: 50))
                            .onTapGesture {
                                showCharacterInfo.toggle()
                            }
                            .sheet(isPresented: $showCharacterInfo){
                                CharacterView(character: vm.character, show: show)
                            }
                        case .sucessEpisode:
                            VStack(alignment: .leading){
                                EpisodeView(episode: vm.episode)
                            }
                        case .faild(let error):
                            Text(error.localizedDescription)
                        }
                        
                        
                        Spacer()
                    }
                    HStack {
                        Button{
                            Task{
                                await vm.getQuoteData(for: show)
                            }
                        }label: {
                            Text("Get Random Quote")
                                .font(.title3)
                                .foregroundStyle(.white)
                                .padding()
                                .background(Color("\(show.removeSpaces())Button"))
                                .clipShape(.rect(cornerRadius: 7))
                                .shadow(color: Color("\(show.removeSpaces())Shadow") , radius: 2)
                        }
                        
                        Spacer()
                        
                        Button{
                            Task{
                                await vm.getEpisodeData(for: show)
                            }
                        }label: {
                            Text("Get Random Episode")
                                .font(.title3)
                                .foregroundStyle(.white)
                                .padding()
                                .background(Color("\(show.removeSpaces())Button"))
                                .clipShape(.rect(cornerRadius: 7))
                                .shadow(color: Color("\(show.removeSpaces())Shadow") , radius: 2)
                        }
                    }
                    .padding(.horizontal, 30)
                    Spacer(minLength: 95)
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .ignoresSafeArea()
        .toolbarBackgroundVisibility(.visible, for: .tabBar)
    }
}

#Preview {
    FetchView(show: Constants.bbName)
        .preferredColorScheme(.dark)
}
