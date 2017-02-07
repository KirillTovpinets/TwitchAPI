//
//  GamesViewController.swift
//  Twitch
//
//  Created by Кірыла on 30.01.17.
//  Copyright © 2017 Кірыла. All rights reserved.
//

import UIKit

class GamesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var gameCollectionView: UICollectionView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Games"
        gameCollectionView.delegate = self
        gameCollectionView.dataSource = self
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(GamesViewController.reloadData ), for: UIControlEvents.valueChanged)
        
        gameCollectionView.insertSubview(refreshControl, at: 0)
        reloadData()
    }

    func reloadData(){
        GameDataService.instance.DownloadTopGames{
            for game in GameDataService.instance.game{
                game.downloadGameImage(completed:{
                    self.gameCollectionView.reloadData()
                    self.loadingIndicator.stopAnimating()
                    self.refreshControl.endRefreshing()
                })
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GameDataService.instance.game.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell", for: indexPath) as? GameCell{
            
            let game = GameDataService.instance.game[indexPath.row]
            cell.configureCell(game)
            
            return cell
        }else{
            return GameCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = gameCollectionView.bounds.width / 2 - 15
        let height = width * (4 / 3)
        return CGSize(width: width, height: height)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
