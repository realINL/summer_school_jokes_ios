//
//  CategoryTAfgView.swift
//  summer_school_jokes
//
//  Created by admin on 18.07.2024.
//

import SwiftUI

struct CategoryTagView: View {
    @State var category: String
    var body: some View {
        Text(category)
            .bold()
            .font(.caption)
            .foregroundColor(.white)
            .padding(5)
            .background(Color("TagColor"))
            .cornerRadius(5)
    }
}

struct CategoryTagView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryTagView(category: "General")
    }
}
