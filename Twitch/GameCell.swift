//
//  GameCell.swift
//  Twitch
//
//  Created by Кірыла on 30.01.17.
//  Copyright © 2017 Кірыла. All rights reserved.
//

import UIKit

class GameCell: UICollectionViewCell {
    
    @IBOutlet weak var gameImageView: UIImageView!
    
    func configureCell(_ game: Game){
        if game.gameImage != nil{
            gameImageView.image = game.gameImage
        }
    }
}
