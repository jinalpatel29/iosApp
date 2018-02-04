//
//  DatePickerViewController.swift
//  curveBall
//
//  Created by Dojo on 1/24/18.
//  Copyright © 2018 Dojo. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {
    
    @IBOutlet weak var datePciker: UIDatePicker!
    
    @IBOutlet weak var shortLabel: UILabel!
    
    @IBOutlet weak var mediumLabel: UILabel!
    
    @IBOutlet weak var longLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        print(sender.date)
        updateLabels()
       
    }

    func updateLabels(){
        let dateFormatter = DateFormatter()
        let new_date = datePciker.date
        
        dateFormatter.dateStyle = .short
        var date = dateFormatter.string(from: new_date)
        self.shortLabel.text = date
        
        dateFormatter.dateStyle = .medium
        date = dateFormatter.string(from: new_date)
        self.mediumLabel.text = date
        
        dateFormatter.dateStyle = .long
        date = dateFormatter.string(from: new_date)
        self.longLabel.text = date
        
    }
    
}
