//
//  PieceService.swift
//  Vinstage
//
//  Created by Roee Kleiner on 08/06/2023.
//

import Foundation

class PieceService {

    let apiURL = URL(string: "http://192.168.137.1:5000/api")!
    let jsonDecoder: JSONDecoder
    let jsonEncoder: JSONEncoder
    init() {
        jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        jsonDecoder.dateDecodingStrategy = .secondsSince1970
        jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
        jsonEncoder.dateEncodingStrategy = .secondsSince1970
    }

    func uploadNewPiece(_ piece: Piece) async {
        var request = URLRequest(url: apiURL)
        request.httpMethod = "POST"
        do {
            let data = try jsonEncoder.encode(piece)
            print(String(data: data, encoding: .utf8)!)
            request.httpBody = data

            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            print(request.httpBody!)
            let (respData, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
                print(String(data: respData, encoding: .utf8)!)

            }
        } catch {
            print("Error encoding piece")
            return
        }
    }

    func getNearbyPieces(location: Location, radius: Int) async -> [Piece] {
        //        return Piece.samplePieces
        var url = URLComponents(url: apiURL, resolvingAgainstBaseURL: true)!
        url.queryItems = [
            URLQueryItem(name: "x", value: String(location.latitude)),
            URLQueryItem(name: "y", value: String(location.longitude)),
            URLQueryItem(name: "radius", value: String(radius)),
        ]
        var request = URLRequest(url: url.url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
            }
            print(String(data: data, encoding: .utf8)!)
            return try jsonDecoder.decode([Piece].self, from: data)

        } catch {
            print(error)

        }
        return []
    }
}
