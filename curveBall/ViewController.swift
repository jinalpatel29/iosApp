//
//  ViewController.swift
//  curveBall
//
//  Created by Dojo on 1/24/18.
//  Copyright © 2018 Dojo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.statusLabel.text = "Switch is On"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func switchOnOff(_ sender: UISwitch) {
        if sender.isOn {
            self.statusLabel.text = "Switch is On"
        }else{
            self.statusLabel.text = "Switch is Off"
        }
    }

}

