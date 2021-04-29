import Foundation

class apiCall {
    
    var page: Int = 1
    var totalPages: Int = 1
    
    var ifLoadingNeeded: Bool {
        page < totalPages
    }

    struct Users: Codable {
        var data: [User]
    }
    var fullUsers: [User] = []
    
    struct Pages: Codable {
        var page: Int
        var total_pages: Int
    }
    
    func getUsers(completion:@escaping ([User]) -> ()) {
        print("Page num: \(self.page)")
        guard let url = URL(string: "https://reqres.in/api/users?page=\(String(page))") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let users = try! JSONDecoder().decode(Users.self, from: data!)
            let pages = try! JSONDecoder().decode(Pages.self, from: data!)
            self.fullUsers.append(contentsOf: users.data)
            self.page = pages.page
            self.totalPages = pages.total_pages
            
            repeat {
                self.page += 1
                print("Page num: \(self.page)")
                guard let url = URL(string: "https://reqres.in/api/users?page=\(String(self.page))") else { return }
                URLSession.shared.dataTask(with: url) { (data, _, _) in
                    let users = try! JSONDecoder().decode(Users.self, from: data!)
                    let pages = try! JSONDecoder().decode(Pages.self, from: data!)
                    self.page = pages.page
                    self.totalPages = pages.total_pages
                    self.fullUsers.append(contentsOf: users.data)
                    print(self.fullUsers)
                    print("BOOM")
            }
            } while self.page < self.totalPages
            
            DispatchQueue.main.async {
                completion(self.fullUsers)
            }
        }
        .resume()
    }
    
    func loadMoreData(completion:@escaping ([User]) -> ()) {
        repeat {
            self.page += 1
            print("Page num: \(self.page)")
            guard let url = URL(string: "https://reqres.in/api/users?page=\(String(self.page))") else { return }
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                let users = try! JSONDecoder().decode(Users.self, from: data!)
                let pages = try! JSONDecoder().decode(Pages.self, from: data!)
                self.page = pages.page
                self.totalPages = pages.total_pages
                self.fullUsers.append(contentsOf: users.data)
                print(self.fullUsers)
                print("BOOM")
                DispatchQueue.main.async {
                    completion(self.fullUsers)
                }
        }
            .resume()
        } while self.page < self.totalPages
    }
    
   
}
