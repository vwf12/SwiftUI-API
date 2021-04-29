//
//  UserView.swift
//  UserJSON
//
//  Created by FARIT GATIATULLIN on 23.04.2021.
//

import SwiftUI

struct UserView: View {
   @State var user: User
    init(user: User) {
        _user = State(initialValue: user)
    }
    var body: some View {
        VStack(alignment: .leading) {
            RemoteImage(url: user.avatar)
                .frame(maxWidth: 100, maxHeight: 100, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
            Text(user.first_name)
                .font(.headline)
                .fontWeight(.bold)
            Text(user.last_name)
                .font(.subheadline)
            Link("\(user.email)", destination: URL(string: "mailto:\(user.email)")!)
            Spacer()
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(user: User(email: "ss", first_name: "ss", last_name: "ss", avatar: "ss"))
    }
}
