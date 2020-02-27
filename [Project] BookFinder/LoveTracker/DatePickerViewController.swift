//
//  DatePickerViewController.swift
//  DemoAppBeenLoveMemoryLite
//
//  Created by dohien on 06/09/2018.
//  Copyright © 2018 dohien. All rights reserved.
//

import UIKit
protocol DatePickerViewControllerDelegate: class {
    func senData(name: String)
    func senDataLove(data: String)
}
class DatePickerViewController: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var nameTextField: UITextField!
    weak var delegate: DatePickerViewControllerDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd/MM/yyyy"
        nameTextField.text = dateFormat.string(from: datePicker.date)
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveDatePicker(_ sender: UIButton) {
        delegate.senData(name: String(interval(start: datePicker.date, end: nameTextField.text!)))
        delegate.senDataLove(data: nameTextField.text!)
        UserDefaults.standard.set(nameTextField.text!, forKey: "loveData")
        UserDefaults.standard.set(interval(start: datePicker.date, end: nameTextField.text!), forKey: "datePicker")
        dismiss(animated: true, completion: nil)
   }
    @IBAction func datePickerSelected(_ sender: UIDatePicker) {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd/MM/yyyy"
        nameTextField.text = dateFormat.string(from: datePicker.date)
    }

    func  interval(start: Date, end: String) -> Int {
        let currentCalendar = Calendar.current
        guard let start = currentCalendar.ordinality(of: .day, in: .era, for: start) else { return 0 }
        guard let end = currentCalendar.ordinality(of: .day, in: .era, for: Date()) else { return 0 }
        return end - start
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
