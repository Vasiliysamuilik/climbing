//
//  ServiceViewController.swift
//  asd
//
//  Created by Vasiliy Samuilik on 4/22/20.
//  Copyright © 2020 Vasiliy Samuilik. All rights reserved.
//

import UIKit

class ServiceViewController: UIViewController {
    
    @IBOutlet weak var labelService: UILabel!
    @IBOutlet weak var labelPeople: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label6: UILabel!
    @IBOutlet weak var label7: UILabel!
    
    @IBOutlet weak var record: UIButton!
    
    var services: Services?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        labelService.text = services?.name
        labelPeople.text = services?.amount
        labelPrice.text = services?.price
        label1.text = services?.about
        label2.text = services?.equipment
        label3.text = services?.instructor
        label4.text = services?.comfort
        label5.text = services?.water
        label6.text = services?.time
        label7.text = services?.plan
    }
    
    @IBAction func makeRecordTapped(_ sender: Any) {
        let recordVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "RecordViewController") as! RecordViewController
        recordVC.service = services
        present(recordVC, animated: true, completion: nil)
    }
    
    
}
