
import Foundation
import UIKit

class DateTextField: UITextField {
    
    fileprivate var pickerView: UIDatePicker = UIDatePicker()
    fileprivate var needSetDate: Bool = true
    var minuteInterval: Int?
    
    var datePickerMode: UIDatePicker.Mode? {
        didSet {
            if let datePickerMode = datePickerMode {
                pickerView.datePickerMode = datePickerMode
            }
        }
    }
    
    var dateFormatter =  DateFormatter() {
        didSet {
            if let date = date, isEditing {
                if dateFormatter.string(from: date).count > 0 {
                    text = dateFormatter.string(from: date)
                } else {
                    text = date.description
                }
            } else if isEditing {
                text = ""
            }
        }
    }
    
    var locale = Locale.current {
        didSet {
            if isEditing {
                if date != nil {
                    pickerView.locale = locale
                }
            }
        }
    }
    
    var calendar = Calendar.current {
        didSet {
            if isEditing {
                if self.date != nil {
                    pickerView.calendar = calendar;
                }
            }
        }
    }
    
    var timeZone: TimeZone? {
        didSet {
            if isEditing {
                if self.date != nil {
                    pickerView.timeZone = timeZone
                }
            }
        }
    }
    
    var minimumDate: Date? {
        didSet {
            if isEditing {
                if self.date != nil {
                    pickerView.minimumDate = minimumDate
                }
            }
        }
    }
    
    var maximumDate: Date? {
        didSet {
            if isEditing {
                if self.date != nil {
                    pickerView.maximumDate = maximumDate
                }
            }
        }
    }
    
    var date: Date? = nil {
        didSet {
            if let date = self.date {
                self.setDate(date: date, animated: false)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    func setup() {
        pickerView.addTarget(self, action: #selector(datePickerChanged(picker:)), for: .valueChanged)
        inputView = pickerView

        NotificationCenter.default.addObserver(self, selector: #selector(didBeginEditing), name: UITextField.textDidBeginEditingNotification, object: self)

        NotificationCenter.default.addObserver(self, selector: #selector(didEndEditing), name: UITextField.textDidEndEditingNotification, object: self)
    }
    
    func addAccessoryToolBar(height: CGFloat = 44, target: Any, sender: UITextField, done: Selector?, cancel: Selector) {
        let accessoryToolbar = AccessoryToolBar(height: height, target: target, done: done, cancel: cancel)
        inputAccessoryView = accessoryToolbar
        
        needSetDate = done == nil
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - Public
    
    @objc func didBeginEditing() {
        pickerView.locale = locale
        pickerView.calendar = calendar
        pickerView.timeZone = timeZone
        pickerView.minimumDate = minimumDate
        pickerView.maximumDate = maximumDate
        
        if let datePickerMode = datePickerMode {
            pickerView.datePickerMode = datePickerMode
        }
    
        if let date = date {
            pickerView.date = date
        }
            
        if let minuteInterval = minuteInterval,
            minuteInterval != 0 && minuteInterval < 31 {
            pickerView.minuteInterval = minuteInterval
        }
    }
    
    @objc func didEndEditing() {
        if needSetDate {
            text = dateFormatter.string(from: pickerView.date)
        }
    }

    //MARK: - Private
    
    fileprivate func setDate(date: Date, animated: Bool, emitted: Bool) {
        if self.date != date {
            self.date = date

            if dateFormatter.string(from: date).count > 0 && needSetDate {
                text = dateFormatter.string(from: date)
            }

            if isEditing {
                if let date = self.date {
                    pickerView.setDate(date, animated: animated)
                }
            }
            if emitted == true {
                sendActions(for: UIControl.Event.valueChanged)
            }
        }
    }
    
    
    @objc fileprivate func datePickerChanged(picker: UIDatePicker) {
        setDate(date: picker.date, animated: false)
    }
    
    func setDate(date: Date, animated:Bool) {
        self.setDate(date: date, animated: animated, emitted: false)
    }
}

class AccessoryToolBar: UIToolbar {
    
    init(height: CGFloat = 44, target: Any, done: Selector? = nil, cancel: Selector) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height))
        
        let doneAction: Selector = done ?? cancel
        let cancelAction: Selector = cancel
        let doneStyle: UIBarButtonItem.Style =  done != nil ? .done : .plain
        
        let doneButton = UIBarButtonItem(title: "Готово", style: doneStyle, target: target, action: doneAction)
        let cancelButton = UIBarButtonItem(title: "Отмена", style: .plain, target: target, action: cancelAction)
        let flexButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    
        if done != nil {
            items = [cancelButton, flexButton, doneButton]
        } else {
            items = [flexButton, doneButton]
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


