//
//  Game.swift
//  Twitch
//
//  Created by Кірыла on 30.01.17.
//  Copyright © 2017 Кірыла. All rights reserved.
//

import UIKit
import Alamofire

class Game {
    var gameName: String
    var gameImageUrl: String
    var gameImage: UIImage?
    
    init(name: String, imageUrl: String) {
        self.gameName = name
        self.gameImageUrl = imageUrl
    }
    
    func downloadGameImage(completed: @escaping downloadComplete){
        request(self.gameImageUrl).responseData { (response) in
            if let data = response.result.value{
                if let image = UIImage(data: data){
                    self.gameImage = image
                }
            }
            completed()
        }
    }
}
