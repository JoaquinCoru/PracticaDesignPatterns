//
//  NetworkModel.swift
//  DragonBallApp
//
//  Created by Joaquín Corugedo Rodríguez on 25/7/22.
//

import Foundation

enum NetworkError: Error, Equatable {
  case malformedURL
  case other
  case noData
  case errorCode(Int?)
  case decoding
}

final class NetworkModel{
    
    let session: URLSession
    
    let token = "eyJhbGciOiJIUzI1NiIsImtpZCI6InByaXZhdGUiLCJ0eXAiOiJKV1QifQ.eyJlbWFpbCI6ImpvYXF1aW5fY29ydUBob3RtYWlsLmNvbSIsImV4cGlyYXRpb24iOjY0MDkyMjExMjAwLCJpZGVudGlmeSI6IjcyNjM4RDY2LUM2NjQtNDc4Qy1CNTNCLUQyQUQ5MDU0NjBDRSJ9._jEMLSg3T0mwE89eEva9NLmqw_BE2TaV9IEvUwx33FM"
    
    
    init(urlSession: URLSession = .shared) {
      self.session = urlSession
    }
    
    func getCharacters(name: String = "", completion: @escaping ([CharacterModel], NetworkError?) -> Void) {
      guard let url = URL(string: "https://vapor2022.herokuapp.com/api/heros/all") else {
        completion([], .malformedURL)
        return
      }
      

      var urlRequest = URLRequest(url: url)
      urlRequest.httpMethod = "POST"
      urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
      urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
      
      struct Body: Encodable {
        let name: String
      }
      
      let body = Body(name: name)
      
      urlRequest.httpBody = try? JSONEncoder().encode(body)
      
      let task = session.dataTask(with: urlRequest) { data, response, error in
        guard error == nil else {
          completion([], .other)
          return
        }
        
        guard let data = data else {
          completion([], .noData)
          return
        }
        
        guard let httpResponse = (response as? HTTPURLResponse),
              httpResponse.statusCode == 200 else {
          completion([], .errorCode((response as? HTTPURLResponse)?.statusCode))
          return
        }
        
        guard let heroesResponse = try? JSONDecoder().decode([CharacterModel].self, from: data) else {
          completion([], .decoding)
          return
        }
        
        completion(heroesResponse, nil)
      }
      
      task.resume()
    }
    
    
}
