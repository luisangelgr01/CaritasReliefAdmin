//
//  ContentView.swift
//  CaritasReliefAdmin
//
//  Created by Alumno on 06/11/23.
//

import SwiftUI

class UserCreds: ObservableObject{
    @Published var user:User = User(token: "", role: 0, user: [0])
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                            in: .userDomainMask,
                                            appropriateFor: nil,
                                            create: false)
        .appendingPathComponent("user.data")
    }
    
    func load() async throws {
            let task = Task<User, Error> {
                let fileURL = try Self.fileURL()
                guard let data = try? Data(contentsOf: fileURL) else {
                                return User(token: "", role: 0, user: [0])
                }
                let User = try JSONDecoder().decode(User.self, from: data)
                return User
            }
        let userCreds = try await task.value
        self.user = userCreds
    }
    
    func save(creds: User) async throws {
            let task = Task {
                let data = try JSONEncoder().encode(creds)
                let outfile = try Self.fileURL()
                try data.write(to: outfile)
            }
            _ = try await task.value
        }
}
