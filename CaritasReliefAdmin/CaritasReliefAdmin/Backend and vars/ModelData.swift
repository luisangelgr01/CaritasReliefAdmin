//
//  ContentView.swift
//  CaritasReliefAdmin
//
//  Created by J. Lugo on 06/11/23.
//

import Foundation
import SwiftUI

//Global vars

var ColorPrincipal = Color(red:0,green: 156/255,blue: 166/255)
var ColorSecundario = Color(red:0,green: 59/255,blue: 92/255)
var Usuario:User = User(token: "", role: 0, user: [0])

//Structures
struct User:Codable{
    let token: String
    let role: Int
    let user: [Int]
}
struct Response:Codable{
    let data: Data
}
struct Data: Codable{
    let recolectores: [Recolector]
}
struct Recolector:Codable, Identifiable{
    let id:String
    let nombres:String
    let apellidos:String
}
/*
struct Response: Codable {
    let data: DataResponse
}

struct DataResponse: Codable {
    let donantes: [Donante]
}

struct Donante: Codable, Identifiable {
    let id: String
    let recibosActivos: [recibosActivos]
}

struct recibosActivos:Codable, Identifiable{
    let cantidad:Double
    let id:String
}

struct Persona:Codable{
    let nombres:String
    let apellidos:String
    let direccion:String
}
*/

//API Calls
func login(username: String, password: String) -> User? {
    var user: User?
    print(Usuario.token)
    let body = """
    {
        "username": "\(username)",
        "password": "\(password)"
    }
    """
    
    guard let url = URL(string: "http://10.14.255.88:8804/auth/login/admin") else {
        return nil
    }
    
    var request = URLRequest(url: url)
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    request.httpBody = body.data(using: .utf8)
    
    let semaphore = DispatchSemaphore(value: 0)
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        defer { semaphore.signal() }
        let jsonDecoder = JSONDecoder()
        if let data = data {
            do {
                user = try jsonDecoder.decode(User.self, from: data)
            } catch {
                print(error)
            }
        }
    }
    
    task.resume()
    semaphore.wait()
    
    return user
}

func getRecolectores(token:String) -> Data{
    let query = """
        {
            recolectores{
                id
                nombres
                apellidos
            }
        }
    """
    guard let url = URL(string: "http://10.14.255.88:8084/graphql") else{
        return Data(recolectores: [])
    }
    
    var request = URLRequest(url:url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    
    let requestBody = ["query": query]
    do{
        let json = try JSONSerialization.data(withJSONObject: requestBody)
        request.httpBody = json
    }catch{
        print("Error creating request body")
        return Data(recolectores: [])
    }
    
    var responseData = Data(recolectores: [])
    
    let semaphore = DispatchSemaphore(value: 0)
    
    let task = URLSession.shared.dataTask(with: request){
        data, response, error in
        defer{
            semaphore.signal()
        }
        if let error = error {
            print("Error: \(error)")
            return
        }

        if let data = data {
            let jsonDecoder = JSONDecoder()
            do {
                let response = try jsonDecoder.decode(Response.self, from: data)
                responseData = response.data
            } catch {
                print("Error decoding GraphQL response: \(error)")
                print(String(data: data, encoding: .utf8))
            }
        }
    }
    task.resume()

    semaphore.wait()
    return responseData
}

/*
func getRecibos(token:String, donante:String, recolector:Int) -> [Donante] {
    let graphQLQuery = """
        {
            donantes(id: \(donante)) {
                id,
                recibosActivos(date: "2023-10-22", idRecolector: \(recolector)) {
                    cantidad,
                    id
                }
            }
        }
    """
    guard let url = URL(string: "http://10.14.255.88:8084/graphql") else {
        return []
    }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    // Replace "YOUR_AUTH_TOKEN_HERE" with your actual authorization token
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

    let requestBody = ["query": graphQLQuery]
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
        request.httpBody = jsonData
    } catch {
        print("Error creating request body: \(error)")
        return []
    }

    var lista: [Donante] = []

    let semaphore = DispatchSemaphore(value: 0)

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        defer {
            semaphore.signal()
        }

        if let error = error {
            print("Error: \(error)")
            return
        }

        if let data = data {
            let jsonDecoder = JSONDecoder()
            do {
                let response = try jsonDecoder.decode(Response.self, from: data)
                lista = response.data.donantes
            } catch {
                print("Error decoding GraphQL response: \(error)")
                print(String(data: data, encoding: .utf8))
                print(donante)
            }
        }
    }
    task.resume()

    semaphore.wait()
    return lista
}
 */
/*

// Usage:
let recibos = getRecibos()
for recibo in recibos {
    print("Recibo ID: \(recibo.id)")
    // Add additional processing as needed
}
*/

struct postponeResponse:Codable{
    let data:postponer
}

struct postponer:Codable{
    let postponerRecibo:Bool
}

func sendComments(recibo:String,comentarios:String,token:String){
    let query = """
    {
        postponerRecibo(id: \(recibo), comentario: "\(comentarios)")
    }
    """
    guard let url = URL(string: "http://10.14.255.88:8084/graphql") else{
        return
    }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    let requestBody = ["query": query]
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
        request.httpBody = jsonData
    } catch {
        print("Error creating request body: \(error)")

        return
    }
    
    let task = URLSession.shared.dataTask(with: request){
        data,response,error in
        let jsonDecoder = JSONDecoder()
        if (data != nil){
            print(String(data: data!, encoding: .utf8))
            print(recibo)
            print(comentarios)
        }else{
            
            return
        }
    }
    task.resume()
}
