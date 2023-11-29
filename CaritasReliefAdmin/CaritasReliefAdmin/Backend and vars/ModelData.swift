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

//
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
//getRecibos
struct Response4: Codable {
    let data: DataResponse
}

struct DataResponse: Codable {
    let recolector: Recolector2
}

struct Recolector2: Codable, Identifiable {
    let id: String
    let recibosActivos: [recibosActivos]
}

struct recibosActivos:Codable, Identifiable{
    let cantidad:Double
    let id:String
    let cobrado: Int
    let comentarios: String
    let donante:Donante
}

struct Donante:Codable, Identifiable{
    let id:String
    let nombres:String
    let apellidos:String
    let direccion:String
    let telCelular:String
    let telCasa:String
}

//getDashChart y getChart
struct Response2:Codable{
    let data: ChartData
}

struct ChartData:Codable{
    let estadoRecibos:EstadoRecibos
}

struct EstadoRecibos:Codable{
    let cobradosFallidos:Int
    let pendiente:Int
    let cobrados:Int
}

//getTotalCobrado
struct Response3:Codable{
    let data:CobradoData
}
struct CobradoData:Codable{
    let totalCobrado:Double
}

//reasignarRecibo
struct Response5:Codable{
    let data:TransferirARecolector
}
struct TransferirARecolector:Codable{
    let transferirARecolector:String
}
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

func getRecibos(token:String, recolector:String) -> Recolector2 {
    let graphQLQuery = """
        {
            recolector(id:\(recolector)){
                id
                recibosActivos(date: "2023-12-01", order: [{cobrado: DESC}]){
                    id,
                    cantidad,
                    cobrado,
                    comentarios,
                    donante{
                        id,
                        nombres,
                        apellidos,
                        direccion,
                        telCelular,
                        telCasa
                    }
                }
            }
        }
    """
    guard let url = URL(string: "http://10.14.255.88:8084/graphql") else {
        return Recolector2(id: "", recibosActivos: [])
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
        return Recolector2(id: "", recibosActivos: [])
    }

    var lista: Recolector2 = Recolector2(id: "", recibosActivos: [])

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
                let response = try jsonDecoder.decode(Response4.self, from: data)
                lista = response.data.recolector
                if let data = try? PropertyListEncoder().encode(lista.recibosActivos) {
                        UserDefaults.standard.set(data, forKey: "recibos")
                    }
            } catch {
                print("Error decoding GraphQL response: \(error)")
                print(String(data: data, encoding: .utf8))
                
            }
        }
    }
    task.resume()

    semaphore.wait()
    return lista
}
/*

// Usage:
let recibos = getRecibos()
for recibo in recibos {
    print("Recibo ID: \(recibo.id)")
    // Add additional processing as needed
}
*/

func reasignarRecibo(token:String, recolector:String, recibo:String) -> TransferirARecolector{
    let query = """
        {
            transferirARecolector(idRecibo: \(recibo), idRecolector: \(recolector))
        }
    """
    guard let url = URL(string: "http://10.14.255.88:8084/graphql") else{
        return TransferirARecolector(transferirARecolector: "NOT OK")
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
        return TransferirARecolector(transferirARecolector: "NOT OK")
    }
    
    var responseData = TransferirARecolector(transferirARecolector: "")
    
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
                let response = try jsonDecoder.decode(Response5.self, from: data)
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

func getChart(token:String, recolector:String)-> EstadoRecibos{
    let query = """
        {
            estadoRecibos(date: "2023-12-01", idRecolector: \(recolector) ){
                cobradosFallidos
                pendiente
                cobrados
            }
        }
    """
    guard let url = URL(string: "http://10.14.255.88:8084/graphql") else{
        return EstadoRecibos(cobradosFallidos: 0, pendiente: 0, cobrados: 0)
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
        return EstadoRecibos(cobradosFallidos: 0, pendiente: 0, cobrados: 0)
    }
    
    var responseData = EstadoRecibos(cobradosFallidos: 0, pendiente: 0, cobrados: 0)
    
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
                let response = try jsonDecoder.decode(Response2.self, from: data)
                responseData = response.data.estadoRecibos
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

func getDashChart(token:String) -> EstadoRecibos {
    let query = """
        {
            estadoRecibos(date: "2023-12-01"){
                cobradosFallidos
                pendiente
                cobrados
            }
        }
    """
    guard let url = URL(string: "http://10.14.255.88:8084/graphql") else{
        return EstadoRecibos(cobradosFallidos: 0, pendiente: 0, cobrados: 0)
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
        return EstadoRecibos(cobradosFallidos: 0, pendiente: 0, cobrados: 0)
    }
    
    var responseData = EstadoRecibos(cobradosFallidos: 0, pendiente: 0, cobrados: 0)
    
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
                let response = try jsonDecoder.decode(Response2.self, from: data)
                responseData = response.data.estadoRecibos
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

func getTotalCobrado(token:String, repartidor:String) -> Double{
    let query = """
        {
            totalCobrado(date: "2023-12-01", idRecolector: \(repartidor))
        }
    """
    guard let url = URL(string: "http://10.14.255.88:8084/graphql") else{
        return 0
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
        return 0
    }
    
    var responseData = 0.0
    
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
                let response = try jsonDecoder.decode(Response3.self, from: data)
                responseData = response.data.totalCobrado
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


func getComentarios(tokenC:String, recolectorC:String) -> [Int] {
    
    let recibosComentarios = getRecibos(token: tokenC, recolector: recolectorC).recibosActivos
    var comentariosCont:[Int] = [0,0,0,0,0,0]
    
    for recibo in recibosComentarios{
        print(recibo.comentarios)
        if(recibo.comentarios == ""){
            comentariosCont[0] += 1
        }else if(recibo.comentarios == "No se encontraba en casa"){
            comentariosCont[1] += 1
        }else if(recibo.comentarios == "Ya no vive ahi"){
            comentariosCont[2] += 1
        }else if(recibo.comentarios == "No desea continuar ayudando"){
            comentariosCont[3] += 1
        }else if(recibo.comentarios == "Indispuesto"){
            comentariosCont[4] += 1
        }else if(recibo.comentarios == "No se ubicó el domicilio"){
            comentariosCont[5] += 1
        }
        
    }
    print(comentariosCont)
    return comentariosCont
    
}

func getCSV(token: String){
    let urlString = "https://equipo20.tc2007b.tec.mx:8443/resumen?date=2023-12-01"
    
    if let url = URL(string: urlString){
        var request = URLRequest (url: url)
        
        request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        
        if UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url)
        }
    }
}
