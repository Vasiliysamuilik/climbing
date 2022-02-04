//
//  AboutViewController.swift
//  asd
//
//  Created by Vasiliy Samuilik on 4/21/20.
//  Copyright © 2020 Vasiliy Samuilik. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    @IBAction func call(_ sender: Any) {
        guard let number = URL(string: "tel://" + "375292890809") else { return }
        UIApplication.shared.open(number)
    }
    
    @IBAction func site(_ sender: Any) {
        if let url = NSURL(string:"http://www.skalodrom-vershina.by/") { UIApplication.shared.open(url as URL) }
    }
    
    @IBAction func mail(_ sender: Any) {
        let supportEmail = "skalodrom.vershina@gmail.com"
        if let emailURL = URL(string: "mailto:\(supportEmail)"), UIApplication.shared.canOpenURL(emailURL)
        {
            UIApplication.shared.open(emailURL, options: [:], completionHandler: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
