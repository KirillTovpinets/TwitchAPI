
//
//  GameDatatService.swift
//  Twitch
//
//  Created by Кірыла on 30.01.17.
//  Copyright © 2017 Кірыла. All rights reserved.
//

import Foundation
import Alamofire

class GameDataService{
    static let instance = GameDataService()
    var nameString, imageUrlString: String!
    
    var game = [Game]()
    
    func DownloadTopGames(completed: @escaping downloadComplete){
        
        let url = TWITCH_URL_TOP_GAMES
        request(url).responseJSON { (response) in
            print(response)
            if let JSON = response.result.value as? [String: Any]{
                if let topGamesArray = JSON["top"] as? [[String: Any]], topGamesArray.count > 0{
                    for i in 0..<topGamesArray.count{
                        if let gameDict = topGamesArray[i]["game"] as? [String: Any]{
                            if let gameName =  gameDict["name"] as? String {
                                self.nameString = gameName
                            }
                            
                            if let boxArt = gameDict["box"] as? [String: Any]{
                                if let imageUrl = boxArt["large"] as? String{
                                    self.imageUrlString = imageUrl
                                }
                            }
                        }
                        let game = Game(name: self.nameString, imageUrl: self.imageUrlString)
                        self.game.append(game)
                    }
                }
            }
            completed()
        }
    }
}
