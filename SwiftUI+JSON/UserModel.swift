import SwiftUI

struct User: Codable, Identifiable {
    let id = UUID()
    let email: String
    let first_name: String
    let last_name: String
    let avatar: String


}
