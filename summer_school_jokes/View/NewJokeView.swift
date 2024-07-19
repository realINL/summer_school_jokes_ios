//
//  JJOkeView.swift
//  summer_school_jokes
//
//  Created by admin on 12.07.2024.
//

import SwiftUI

struct NewJokeView: View {
    @StateObject private var networkManager = NetworkManager()
    @State private var isLiked: Bool = false
    var joke: Joke
    @State private var numberOfLikes: Int = 5
    @State private var like: Bool = false
    var body: some View {
        VStack {
            HStack{
                
                Text(joke.title)
                    .bold()
                
                
                Spacer()
                Text("by")
                    .foregroundColor(.secondary)
                    .font(.caption)
                Text("Admin")
                    .font(.subheadline)
                
            }
            

//            .foregroundColor(.blue)
//            .padding(0)
//            Divider()
            HStack() {
                
                Text(joke.text)
                    .foregroundColor(.primary)
                
                Spacer()
            }
            HStack {
                let tags = joke.tags.split(separator: ", ").map(String.init)

                           ForEach(tags, id: \.self) { tag in
                               CategoryTagView(category: tag)
                           }
                Spacer()
            }
            
//            Divider()
                
            HStack {
                Text(String(joke.date.prefix(10)))
                    .foregroundColor(.secondary)
                    .font(.caption)
                
                Spacer()
                
                
                Button{
                    like.toggle()
                    if (isLiked) {
                        like(jokeId: joke.id, isLiked: false)
                    } else {
                        like(jokeId: joke.id, isLiked: true)
                    }
                }
            label: {
                VStack {
                    if (!isLiked) {
                        Image (systemName: "hand.thumbsup")
                            .foregroundColor(.black)
                    } else {
                        Image (systemName: "hand.thumbsup.fill")
                            .foregroundColor(.black)
                        
                    }
                    //            .cornerRadius(120)
                    //                    .background(Color(.systemGreen))
                    
                    Text("\(joke.likes)")
                        .font(.callout)
                        .foregroundColor(.black)
                }
                
            }
                
                
            }
        }
        .padding()
        //        .frame(width:  UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.06)
        .background(Color("WhiteSmoke"))
        .cornerRadius(10)
//        .shadow(radius: 5)
        .padding()
        .onAppear {
                    loadLikeStatus()
                }
        
    }
    
    private func loadLikeStatus() {
           Task {
               isLiked = await networkManager.checkLikeStatus(for: joke.id)
           }
       }
    
    private func like(jokeId:Int, isLiked: Bool) {
        Task {
            try await networkManager.toggleLikeStatus(for: jokeId, isLiked: isLiked)
        }
    }
    
}

struct NwJokeView_Previews: PreviewProvider {
    static var previews: some View {
        NewJokeView(joke: Joke.MOCK_JOKE)
    }
}

