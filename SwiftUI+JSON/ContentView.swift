import SwiftUI

struct ContentView: View {
    
    @State var users: [User] = []

    var body: some View {
        NavigationView {
        List(users) { user in
          
            NavigationLink(
                destination: UserView(user: user)) {
                HStack {
                    RemoteImage(url: user.avatar)
                        
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .shadow(radius: 5)
                        .padding(.trailing, 5)
                    Spacer()
                    VStack {
                        Group {
                        Text(user.first_name)
                            .font(.headline)
                        Text(user.last_name)
                            .font(.subheadline)
                        Button("\(user.email)") {
                            UIApplication.shared.open(URL(string: "mailto:\(user.email)")!)
                        }
                        .font(.footnote)
                        .foregroundColor(.gray)
                        }
                    }
                    Spacer()
                }
            }
                
            
        }
            .onAppear {
                apiCall().getUsers { (users) in
                    self.users = users
                }
                apiCall().loadMoreData { (users) in
                    self.users.append(contentsOf: users)
                }
            }
    }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
