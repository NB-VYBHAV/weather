//
//  newViewController.swift
//  weather
//
//  Created by Mdit on 02/08/19.
//  Copyright © 2019 Mdit. All rights reserved.
//

import UIKit
protocol Citychng {
    func citysnd(city:String)
    
}

class newViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cityArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cityArray[row]
    }
   
    var delegate : citychng?
    
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var txt2: UITextField!
    @IBAction func btnbak(_ sender: UIButton) {
//      var dataText = ""
        delegate?.citysnd(city: txt2.text!)
        dismiss(animated: true, completion: nil)
    }
    let cityArray = ["kochi","Thiruvanathapuram","calicut","malapuram","london","rio","Alaska"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        print(cityArray[row])
//        txt2.text = cityArray[row]
        
        delegate?.citysnd(city: cityArray[row])
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
