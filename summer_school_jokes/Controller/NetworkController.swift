//
//  NetworkController.swift
//  summer_school_jokes
//
//  Created by admin on 18.07.2024.
//

import SwiftUI

class NetworkManager: ObservableObject {
    @Published var jokes: [Joke] = []
    @Published var filteredJokes: [Joke] = []
    @Published var topJokes: [Joke] = []
    @Published var MyJokes: [Joke] = []
    @AppStorage("isAuthenticated") var isAuthenticated = false
    @Published var accessToken: String? {
            didSet {
                if let token = accessToken {
                    UserDefaults.standard.set(token, forKey: "accessToken")
                }
            }
        }
        
        init() {
            self.accessToken = UserDefaults.standard.string(forKey: "accessToken")
        }
    let baseURL = "http://localhost:8008"
    
    func fetchJokes() {
        guard let url = URL(string: "\(baseURL)/jokes") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error fetching jokes: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data returned")
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode([String: [Joke]].self, from: data)
                DispatchQueue.main.async {
                    self.jokes = decodedResponse["jokes"] ?? []
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }.resume()
    }
    
//    func createJoke(_ joke: Joke) async {
//        guard let url = URL(string: "http://localhost:8008/jokes") else { return }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//
//        if let token = accessToken {
//            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//        } else {
//            print("No access token available")
//            return
//        }
//
//        let body: [String: Any] = [
//            "title": joke.title,
//            "text": joke.text,
//            "tags": joke.tags
//        ]
//
//        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
//        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
//
//        do {
//            let (data, response) = try await URLSession.shared.data(for: request)
//
//            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 {
//                print("Joke created successfully")
//            } else {
//                print("Failed to create joke")
//                if let responseString = String(data: data, encoding: .utf8) {
//                    print("Response data: \(responseString)")
//                }
//            }
//        } catch {
//            print("Error creating joke: \(error.localizedDescription)")
//        }
//    }
    
    
//    func login(username: String, password: String) async -> Bool {
//            guard let url = URL(string: "http://localhost:8008/login") else { return false }
//
//            var request = URLRequest(url: url)
//            request.httpMethod = "POST"
//            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
//
//            let body: [String: Any] = [
//                "username": username,
//                "password": password
//            ]
//
//            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
//
//            do {
//                let (data, response) = try await URLSession.shared.data(for: request)
//
//                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
//                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
//                       let token = json["access_token"] as? String {
//                        accessToken = token
//                        return true
//                    }
//                }
//            } catch {
//                print("Error logging in: \(error.localizedDescription)")
//            }
//            return false
//        }
        
    func login(username: String, password: String) async -> Bool {
            guard let url = URL(string: "http://localhost:8008/login") else { return false }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let body: [String: Any] = [
                "username": username,
                "password": password
            ]
            
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
            
            do {
                let (data, response) = try await URLSession.shared.data(for: request)
                
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let token = json["access_token"] as? String {
                        accessToken = token
                        return true
                    }
                }
            } catch {
                print("Error logging in: \(error.localizedDescription)")
            }
            return false
        }

    
    func createJoke(_ joke: Joke) async {
            guard let url = URL(string: "http://localhost:8008/create-joke") else { return }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            if let token = accessToken {
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            } else {
                print("No access token available")
                return
            }
            
            let body: [String: Any] = [
                "title": joke.title,
                "text": joke.text,
                "tags": joke.tags
            ]
            
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            do {
                let (data, response) = try await URLSession.shared.data(for: request)
                
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 {
                    print("Joke created successfully")
                } else {
                    print("Failed to create joke")
                    if let responseString = String(data: data, encoding: .utf8) {
                        print("Response data: \(responseString)")
                    }
                }
            } catch {
                print("Error creating joke: \(error.localizedDescription)")
            }
        }

    
    func checkLikeStatus(for jokeId: Int) async -> Bool {
           guard let url = URL(string: "http://localhost:8008/is-liked/\(jokeId)") else { return false }
           
           var request = URLRequest(url: url)
           request.httpMethod = "GET"
           if let token = accessToken {
               request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
           }
           
           do {
               let (data, _) = try await URLSession.shared.data(for: request)
               // Печатаем для проверки, что получаем
               let responseString = String(data: data, encoding: .utf8)
               print("Response data: \(responseString ?? "No data")")
               
               // Парсим данные
               let responseJSON = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String]
               if let isLiked = responseJSON?["is_liked"] {
                   return isLiked == "true"
               } else {
                   print("Unexpected response format")
                   return false
               }
           } catch {
               print("Failed to check like status: \(error.localizedDescription)")
               return false
           }
       }
    
    func toggleLikeStatus(for jokeId: Int, isLiked: Bool) async {
            guard let url = URL(string: "http://localhost:8008/like-post/\(jokeId)/") else { return }
            
            var request = URLRequest(url: url)
            request.httpMethod = isLiked ? "DELETE" : "POST"
            if let token = accessToken {
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
            
            do {
                let (_, _) = try await URLSession.shared.data(for: request)
            } catch {
                print("Failed to toggle like status: \(error.localizedDescription)")
            }
        }
    
    func filterJokes(by category: Category?) {
            if let category = category {
                filteredJokes = jokes.filter { joke in
                    joke.tags.contains(category.rawValue)
                }
            } else {
                filteredJokes = jokes
            }
        }
    
    func filterJokes(by userId: Int) {
        
            MyJokes = jokes.filter { joke in
                joke.userId == userId
            }
        
    }
    
    func updateTopJokes() {
            topJokes = jokes.sorted { $0.likes > $1.likes }.prefix(10).map { $0 }
        }
    
    func login(username: String, password: String, completion: @escaping (Bool) -> Void) {
            guard let url = URL(string: "\(baseURL)/login") else { return }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            let body: [String: Any] = ["username": username, "password": password]
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)

            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print("Login error: \(error?.localizedDescription ?? "No data")")
                    completion(false)
                    return
                }

                if let httpResponse = response as? HTTPURLResponse {
                    print("HTTP Status Code: \(httpResponse.statusCode)")
                }

                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                if let responseJSON = responseJSON as? [String: Any], let token = responseJSON["access_token"] as? String {
                    DispatchQueue.main.async {
                        self.accessToken = token
                        self.isAuthenticated = true
                        completion(true)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(false)
                    }
                }
            }.resume()
        }
}
