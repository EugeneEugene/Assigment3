//
//  ViewController.swift
//  Assigment3
//
//  Created by eugene on 03/05/2018.
//  Copyright © 2018 eugene. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var playingTableOutlet: PlayingTableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("grid count: \(playingTableOutlet.grid.cellCount)")
        for index in 0..<playingTableOutlet.grid.cellCount {
            let b = UIBezierPath(rect: playingTableOutlet.grid[1,1]!)
            UIColor.red.setFill()
            b.fill()
        }
        playingTableOutlet.setNeedsLayout()
        playingTableOutlet.setNeedsDisplay()
    }




}

