//
//  JokesScrollView.swift
//  summer_school_jokes
//
//  Created by admin on 17.07.2024.
//

import SwiftUI

struct JokesScrollView<JokeViewContent: View>: View {
    let jokeView: JokeViewContent
    @State var numberOfJokes: Int = 5
    @State var jokes: [Joke]
    var body: some View {
        ScrollView{
            LazyVStack {
                ForEach(0..<numberOfJokes) {
                    index in jokeView
                }
            }
            
        }
        
    }
//        .onAppear() {
//            numberOfJokes = jokes.count
//        }
        
}

struct JokesScrollView_Previews: PreviewProvider {
    static var previews: some View {
        JokesScrollView(jokeView: JokeView(), jokes: [Joke.MOCK_JOKE, Joke.MOCK_JOKE])
    }
}
