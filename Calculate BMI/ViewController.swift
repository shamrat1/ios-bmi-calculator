//
//  ViewController.swift
//  Calculate BMI
//
//  Created by Leads Computer on 11/25/19.
//  Copyright © 2019 Leads Computer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var weightUnit: UIPickerView!
    @IBOutlet weak var heightUnit: UIPickerView!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var outputArea: UILabel!
    
    
    let poundToKg = 0.453592
    var weightPickerRow = 0 , heightPickerRow = 0
    var heightPickerUnit = ["meter","centimeters"]
    var weightPickerUnit = ["Kgs","Lbs"]
    var weight = 0.0 //in KG
    var height = 0.0 // in centimeter
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //setting datasource
        self.weightUnit.delegate = self
        self.weightUnit.dataSource = self
        self.heightUnit.delegate = self
        self.heightUnit.dataSource = self
        outputArea.isHidden = true
    }
    
    
    
    @IBAction func calculate(_ sender: Any) {
        outputArea.isHidden = false
            convertUnit()
        let bmi = weight / (height * height)
        
        if bmi <= 18.5 {
            outputArea.text = "Underweight"
            outputArea.backgroundColor = UIColor.yellow
            animate()
        }else if bmi > 18.5 && bmi < 24.9 {
            outputArea.text = "Normal"
            outputArea.backgroundColor = UIColor.green
            animate()
        }else if bmi > 25 && bmi < 29.9 {
            outputArea.text = "Overweight"
            outputArea.backgroundColor = UIColor.yellow
            animate()
        }else {
            outputArea.text = "Obese"
            outputArea.backgroundColor = UIColor.red
            animate()
        }
        weightField.text = ""
        heightField.text = ""
    }
    
    
    func animate(){
        self.outputArea.fadeIn(completion: {
        (finished: Bool) -> Void in
        self.outputArea.fadeOut()
        })
    }
    
    
    func convertUnit(){
        if weightPickerUnit[weightPickerRow] == "Lbs" {
            if let pound = weightField.text {
                weight = Double((Double(pound) ?? 0.0) * poundToKg)
            }
        }else {
            weight = Double(weightField.text!)!
        }
        
        if heightPickerUnit[heightPickerRow] == "centimeters" {
            if let centimeter = heightField.text {
                height = Double((Double(centimeter) ?? 0.0) / 100)
            }
        }else{
            height = Double(heightField.text!)!
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if pickerView == weightUnit{
            weightPickerRow = row
        }
        if pickerView == heightUnit {
            heightPickerRow = row
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
           // Dispose of any resources that can be recreated.
       }
    
       // Number of columns of data
       func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }
       
       // The number of rows of data
       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == weightUnit {
            return weightPickerUnit.count
        }else{
            return heightPickerUnit.count
        }
       }
       
       // The data to return fopr the row and component (column) that's being passed in
       func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == weightUnit {
            return weightPickerUnit[row]
        }else {
            return heightPickerUnit[row]
        }
    }
    
}

extension UIView {
    func fadeIn(duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)
    }

    func fadeOut(duration: TimeInterval = 1.0, delay: TimeInterval = 3.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
}
