//
//  RecordViewController.swift
//  asd
//
//  Created by Vasiliy Samuilik on 5/15/20.
//  Copyright © 2020 Vasiliy Samuilik. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class RecordViewController: UIViewController {
    
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var inputName: UITextField!
    @IBOutlet weak var inputPhone: UITextField!
    @IBOutlet weak var dateTextField: DateTextField!
    
    var service: Services?
    
    @IBAction func sendRecord(_ sender: Any) {
        addRecord()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataPicker()
    }
    
    fileprivate func configureDataPicker() {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        
        dateTextField.addAccessoryToolBar(target: self,
                                               sender: dateTextField,
                                               done: nil, cancel: #selector(timeTextFieldResing))
        
        dateTextField.dateFormatter = dateFormatter
        dateTextField.datePickerMode = .dateAndTime
        dateTextField.minuteInterval = 60
        dateTextField.textColor = #colorLiteral(red: 0, green: 0.463, blue: 1, alpha: 1)
        dateTextField.locale = Locale(identifier: "ru_RU")
    }
    
    @objc private func timeTextFieldResing() {
        dateTextField.resignFirstResponder()
    }
    
    func addRecord() {
        
        if inputName.text == nil || inputName.text?.isEmpty ?? false {
            alert("Ошибка", message: "Введите пожалуйста имя")
            return
        }
        
        if inputPhone.text == nil || inputPhone.text?.isEmpty ?? false {
            alert("Ошибка", message: "Введите пожалуйста номер телефона")
            return
        }
        
        if dateTextField.date == nil {
            alert("Ошибка", message: "Выберите пожалуйста дату записи")
            return
        }
        
        let record: Record = Record(clientName: inputName.text!, phone: inputPhone.text!, date: dateTextField.date!, serviceId: service?.id ?? "")
        
        FirebaseManager.shared.createRecord(record) { [weak self] result in
            switch result {
            case .value(_):
                self?.alert("Ваша запись успешно добавлена !") { [weak self] action in
                    guard action.style == .cancel else { return }
                    self?.dismiss(animated: true, completion: nil)
                }
            case .error(let error):
                self?.alert(error.localizedDescription)
            }
        }
        
    }
    
    func alert(_ title: String?, message: String? = nil, cancel: String? = nil, buttons: [String]? = nil, completion: ((UIAlertAction) -> Void)? = nil) {
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        var cancelTitle: String = "Ok"
        if cancel != nil {
            cancelTitle = cancel!
        }
        let action: UIAlertAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: { (alertAction) in
            if completion != nil {
                DispatchQueue.main.async {
                    completion!(alertAction)
                }
            }
        })
        alert.addAction(action)
        
        if buttons != nil {
            for buttonTitle in buttons! {
                let action: UIAlertAction = UIAlertAction(title: buttonTitle, style: .default, handler: { (alertAction) in
                    if completion != nil {
                        DispatchQueue.main.async {
                            completion!(alertAction)
                        }
                    }
                })
                alert.addAction(action)
            }
        }
        
        present(alert, animated: true, completion: nil)
    }
}

