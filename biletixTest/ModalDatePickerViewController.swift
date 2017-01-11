//
//  ModalDatePickerViewController.swift
//  biletixTest
//
//  Created by Andrey Ildyakov on 10.01.17.
//  Copyright © 2017 Andrey Ildyakov. All rights reserved.
//

import UIKit
protocol datePickerDelegate: class {
    func changeDate(startDate:Bool, date:NSDate)
}
class ModalDatePickerViewController: UIViewController {
    var delegate: datePickerDelegate?
    var startDate = true
    @IBOutlet weak var closeModalButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBAction func closeModalAction(sender: AnyObject) {
        delegate?.changeDate(startDate, date: datePicker.date)
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configButton()
        navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        // Do any additional setup after loading the view.
    }
    func configButton() {
        closeModalButton.layer.borderWidth = 2
        closeModalButton.layer.cornerRadius = 3
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
