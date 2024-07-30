//
//  LeaerBoardView.swift
//  summer_school_jokes
//
//  Created by admin on 18.07.2024.
//

import SwiftUI

struct LeaerBoardView: View {
    
    @StateObject private var networkManager = NetworkManager()
    //    @State var jokes: [Joke]
    
    var body: some View {
        VStack {
            HStack {
                Label("Summer school jokes", systemImage: "book")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                Spacer()
            }
            
            Text("Top 10 jokes")
                .font(.title3)
                .fontWeight(.semibold)
                .padding(4)
            
            
            
            //            .padding(.leading, 15)
            ScrollView {
                LazyVStack {
                    ForEach(networkManager.topJokes) { joke in
                        NewJokeView(joke: joke)
                    }
                }
            }
            .onAppear {
                networkManager.fetchJokes()
                networkManager.updateTopJokes()
            }
            
        }
    }
    
    
}

struct LeaerBoardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaerBoardView()
    }
}
