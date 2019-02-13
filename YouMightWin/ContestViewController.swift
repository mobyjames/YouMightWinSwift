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

    enum ContestState {
        case initial
        case loading
        case started
        case selected
    }
    
    @IBOutlet var contestants: [ContestantView]!
    @IBOutlet weak var startRound: UIButton!
    @IBOutlet weak var pickWinner: UIButton!
    
    var state: ContestState = .initial
    var raffle: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setState(state: .initial)
    }
    
    @IBAction func startRoundAction(_ sender: Any) {
        setState(state: .loading)
        
        Alamofire.request("https://45kal3jvm8.execute-api.us-west-2.amazonaws.com/live/round").responseJSON { response in
            do {
                let json = try JSON(data: response.data!)

                self.raffle = []

                for i in 0...4 {
                    let contestant = self.contestants[i]
                    let info = json[i]
                    let name = info["name"].stringValue
                    let points = info["points"].intValue
                    let avatarFileName = String(format: "avatar_%03d", info["avatar"].intValue)

                    contestant.isHidden = false;
                    contestant.name.text = name
                    contestant.avatar.image = UIImage.init(named: avatarFileName)
                    contestant.points.text = "\(points)"
                    
                    self.raffle.append(contentsOf: Array(repeating: i, count: points))
                }

                self.setState(state: .started)
            } catch {
                self.setState(state: .initial)
            }
        }
    }
    
    @IBAction func pickWinnerAction(_ sender: Any) {
        resetWinner();
        
        let ticket = Int.random(in: 0 ..< raffle.count - 1)
        let selection = raffle[ticket]
        let contestant = self.contestants[selection]
        contestant.star.isHidden = false
        
        self.setState(state: .selected)
    }
    
    func resetWinner() {
        for contestant in contestants {
            contestant.star.isHidden = true
        }
    }
    
    func setState(state: ContestState) {
        switch state {
        case .initial:
            resetWinner()
            pickWinner.isEnabled = false
            pickWinner.setTitleColor(UIColor.gray, for: .normal)
            startRound.isEnabled = true
            startRound.setTitleColor(UIColor.white, for: .normal)
        case .loading:
            resetWinner();
            pickWinner.isEnabled = false
            pickWinner.setTitleColor(UIColor.gray, for: .normal)
            startRound.isEnabled = false
            startRound.setTitleColor(UIColor.gray, for: .normal)
        case .started:
            pickWinner.isEnabled = true
            pickWinner.setTitleColor(UIColor.white, for: .normal)
            startRound.isEnabled = false
            startRound.setTitleColor(UIColor.gray, for: .normal)
        case .selected:
            pickWinner.isEnabled = true
            pickWinner.setTitleColor(UIColor.white, for: .normal)
            startRound.isEnabled = true
            startRound.setTitleColor(UIColor.white, for: .normal)
        }
        
    }
}
