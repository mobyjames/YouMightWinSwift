//
//  ContestViewController.swift
//  YouMightWin
//
//  Created by James Jacoby on 2/7/19.
//  Copyright © 2019 Moby, Inc. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ContestViewController: UIViewController {

    @IBOutlet var contestants: [ContestantView]!
    @IBOutlet weak var startRound: UIButton!
    @IBOutlet weak var pickWinner: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startRoundAction(_ sender: Any) {
        Alamofire.request("https://45kal3jvm8.execute-api.us-west-2.amazonaws.com/live/round").responseJSON { response in
            
            do {
                let json = try JSON(data: response.data!)

                for i in 0...4 {
                    let contestant = self.contestants[i]
                    let info = json[i]
                    let name = info["name"].stringValue
                    let points = info["points"].stringValue
                    let avatarFileName = String(format: "avatar_%03d", info["avatar"].intValue)

                    contestant.isHidden = false;
                    contestant.name.text = name
                    contestant.avatar.image = UIImage.init(named: avatarFileName)
                    contestant.points.text = points
                }
            } catch {
                // log?
            }
        }
    }
    
    @IBAction func pickWinnerAction(_ sender: Any) {
        let selection = Int.random(in: 0 ..< 5)
        let contestant = self.contestants[selection]
        contestant.star.isHidden = false
    }
}
