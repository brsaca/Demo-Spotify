//
//  AudioVC.swift
//  Spot
//
//  Created by Brenda Saavedra on 08/04/17.
//  Copyright © 2017 Brenda Saavedra. All rights reserved.
//

import UIKit
import Kingfisher
import AVFoundation

class AudioVC: UIViewController {
    
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var imgSong:UIImageView!
    @IBOutlet weak var imgBackground:UIImageView!
    
    var song:Song!

    override func viewDidLoad() {
        super.viewDidLoad()

        lblTitle.text = song.name
        imgSong.kf.setImage(with: song.urlImage)
        imgBackground.kf.setImage(with: song.urlImage)
        
        downloadFileFromURL(url: song.urlPreview)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if player.isPlaying {
             player.stop()
        }
    }
    
    func downloadFileFromURL(url: URL) {
        var downloadTask = URLSessionDownloadTask()
        downloadTask = URLSession.shared.downloadTask(with: url, completionHandler: { (customURL:URL?, response:URLResponse?, error:Error?) in
            self.play(url: customURL!)
        })
        downloadTask.resume()
    }
    
    func play(url: URL) {
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            player.play()
        } catch {
            print(error)
        }
    }

}
