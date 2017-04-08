//
//  SearchVC.swift
//  Spot
//
//  Created by Brenda Saavedra on 08/04/17.
//  Copyright © 2017 Brenda Saavedra. All rights reserved.
//

import UIKit
import Alamofire
import AVFoundation

typealias JSONStandard = [String: AnyObject]

var player = AVAudioPlayer()

class SearchVC: UITableViewController {
    
    var searchURL = "https://api.spotify.com/v1/search?q=dont+speak&type=track&limit=20"

    var songs = [Song]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        callAlamo(url: searchURL)
    }

    func callAlamo(url:String){
        Alamofire.request(url).responseJSON(completionHandler: {
            response in
            self.parseData(JSONData: response.data!)
        })
    }
    
    func parseData(JSONData: Data){
        do {
            var readableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! JSONStandard
            if let tracks = readableJSON["tracks"] as? JSONStandard {
                if let items = tracks["items"] as? [JSONStandard] {
                    for ii in  0..<items.count {
                        let item = items[ii]
                        let song = Song.init(fromData:item)
                        songs.append(song)
                    }
                    self.tableView.reloadData()
                }
            }
            
        } catch {
            print (error)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SongCell
        cell.configureCell(song: songs[indexPath.row])
        return cell
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = self.tableView.indexPathForSelectedRow?.row
        let vc = segue.destination as! AudioVC
        vc.song = songs[indexPath!]
        
    }
    

}
