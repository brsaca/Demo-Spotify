//
//  SongCell.swift
//  Spot
//
//  Created by Brenda Saavedra on 08/04/17.
//  Copyright © 2017 Brenda Saavedra. All rights reserved.
//

import UIKit
import Kingfisher

class SongCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var imgSong: UIImageView!
    
    
    func configureCell(song:Song){
        lblTitle.text = song.name
        lblType.text = song.type
        imgSong.kf.setImage(with: song.urlImage)
    }

}
