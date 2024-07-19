 //
//  Joke.swift
//  summer_school_jokes
//
//  Created by admin on 12.07.2024.
//

import Foundation
//struct Joke: Identifiable, Codable {
//    let id: Int
//    let title: String
//    let text: String
//    let tags: String
//    let pub_date: String
//    let user_id: Int
//}

struct Joke: Identifiable, Codable {
    var id: Int = 0
    var title: String
    var text: String
    var tags: String
    var userId: Int = 0
    var date: String = "0"
    var likes: Int = 0
}


extension Joke {
    static var MOCK_JOKE = Joke(id: 0, title: "Шутка о веганах", text: " - Знаешь какая часть овоща самая трудножущаяся?\n - Инвалидная коляска.", tags: "General, Technology", userId: 0, date: "22.05.2023", likes: 0)
}
