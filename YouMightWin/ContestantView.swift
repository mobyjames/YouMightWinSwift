//
//  ContestantView.swift
//  YouMightWin
//
//  Created by James Jacoby on 2/7/19.
//  Copyright © 2019 Moby, Inc. All rights reserved.
//

import UIKit

class ContestantView: UIView {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var star: UIImageView!
    
    var view: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        backgroundColor = UIColor.clear;

        view = loadViewFromNib()
        view.frame = bounds
        view.bounds = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(view)
        
        points.layer.cornerRadius = 10
        points.layer.masksToBounds = true;
        
        setWinningState(false)
    }
    
    func loadViewFromNib() -> UIView! {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    func setWinningState(_ winner: Bool) {
        star.isHidden = !winner;
    }
}
