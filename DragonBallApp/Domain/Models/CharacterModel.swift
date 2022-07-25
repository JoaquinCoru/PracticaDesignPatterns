//
//  CharacterModel.swift
//  DragonBallApp
//
//  Created by Joaquín Corugedo Rodríguez on 24/7/22.
//

import Foundation

struct CharacterModel :Decodable{
    let photo:URL
    let name:String
    let description:String
}

let sampleCharactersData: [CharacterModel] = try! JSONDecoder().decode([CharacterModel].self, from: getCharactersData(resourceName: "heroes")!)


func getCharactersData(resourceName: String) -> Data? {
    let bundle = Bundle(for: HomeViewController.self)
  
  guard let path = bundle.path(forResource: resourceName, ofType: "json") else {
    return nil
  }
  
  return try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
}
