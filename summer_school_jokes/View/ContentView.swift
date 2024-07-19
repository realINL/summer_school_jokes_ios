//
//  ContentView.swift
//  summer_school_jokes
//
//  Created by admin on 12.07.2024.
//

import SwiftUI

struct ContentView: View {
    
    init() {
            UITabBar.appearance().tintColor = UIColor.black
        }
    @StateObject private var networkManager = NetworkManager()
    @State private var username = ""
    @State private var password = ""
    @AppStorage("isAuthenticated") var isAuthenticated = false
    
    var body: some View {
        TabView {
            HomeView()
//                .onAppear {
//                    networkManager.fetchJokes()
//                }
                .tabItem{
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            LeaerBoardView()
                .tabItem{
                    Image(systemName: "chart.line.uptrend.xyaxis")
                    Text("LeaderBoard")
                }
            RandomJokeView()
                .tabItem{
                    Image(systemName: "shuffle")
                    Text("Random Joke")
                }
            
//            ProfileView(user: User.MOCK_USER, newJoke: .constant(""))
            if (!isAuthenticated) {
                LogInView(username: $username, password: $password)
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
            }
            else {
                ProfileView(user: User.MOCK_USER, newJoke: .constant(""))
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
            }
            
               
        }
        .accentColor(.primary)
        ////        HomeView()
        //        ProfileView(user: User.MOCK_USER,newJoke: .constant(""))
        ////        VStack {
        ////            Image(systemName: "globe")
        ////                .imageScale(.large)
        ////                .foregroundColor(.accentColor)
        ////            Text("Hello, world!")
        ////        }
        ////        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
