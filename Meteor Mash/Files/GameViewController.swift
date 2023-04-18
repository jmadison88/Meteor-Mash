//
//  GameViewController.swift
//  Meteor Mash
//
//  Created by Josh Madison on 4/13/23.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let scene = Intro(fileNamed:"Intro") {
              let skView = self.view as! SKView
              //setup your scene here
              skView.presentScene(scene)
        }
        
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
