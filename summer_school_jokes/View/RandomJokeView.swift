//
//  RandomJokeView.swift
//  summer_school_jokes
//
//  Created by admin on 18.07.2024.
//

import SwiftUI

struct RandomJokeView: View {
    @StateObject private var networkManager = NetworkManager()
    @State private var randomIndex: Int = 0
    @State private var scale: CGFloat = 1.0
    @State private var showJoke = false
    

    var body: some View {
        VStack {
            if showJoke {
                VStack {
                    NewJokeView(joke: networkManager.jokes[randomIndex])
                    Text("Cancel")
                        .foregroundColor(.primary)
                        .padding(5)
                        .background(Color("WhiteSmoke"))
                        .cornerRadius(5)
                        .onTapGesture {
                            withAnimation {
                                showJoke.toggle()
                            }
                            startScaling()
                        }
                }
                
            } else {
                DiceView(scale: $scale)
                    .onTapGesture {
                        networkManager.fetchJokes()
                        randomIndex = Int.random(in: 0...networkManager.jokes.count)
                        withAnimation {
                            showJoke.toggle()
                        }
                    }
                    .onAppear {
                        startScaling()
                    }
            }
        }
        .onAppear {
            networkManager.fetchJokes()
            randomIndex = Int.random(in: 0...networkManager.jokes.count)
            print(randomIndex)
        }
    }

    private func startScaling() {
        scale = 1.0
        withAnimation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
            scale = 1.2
        }
    }
}

struct DiceView: View {
    @Binding var scale: CGFloat
    @State var size: CGFloat = 100
    
    var body: some View {
        Text("🎲")
            .font(.system(size: size))
            .scaleEffect(scale)
    }
}



struct RandomJokeView_Previews: PreviewProvider {
    static var previews: some View {
        RandomJokeView()
    }
}
