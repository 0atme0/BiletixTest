//
//  ViewController.swift
//  biletixTest
//
//  Created by Andrey Ildyakov on 10.01.17.
//  Copyright © 2017 Andrey Ildyakov. All rights reserved.
//

import UIKit
import GooglePlaces


class SearchViewController: UIViewController,datePickerDelegate,UITextFieldDelegate {
    let load = LoadData()
    var placesClient: GMSPlacesClient?
    let formatter = NSDateFormatter()
    var sourceTableHotels : [HotelModel] = []
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var dateStart: UITextField!
    @IBOutlet weak var dateFinish: UITextField!
  
    private var responseData:NSMutableData?
    private var dataTask:NSURLSessionDataTask?
    
    @IBAction func searchAction(sender: AnyObject) {
        load.postRequest(cityField.text!, accommodationArrival: formatter.dateFromString(dateStart.text!)!, accommodationDeparture: formatter.dateFromString(dateFinish.text!)!, completion: { hotels in
                dump(hotels)

                self.sourceTableHotels = hotels
                self.performSegueWithIdentifier("showHotels", sender: nil)
            
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavBar()
        configDelegates()
        configButton()
    }
    func configNavBar() {
        navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.barStyle = UIBarStyle.Black
    }
    
    func configDelegates() {
        dateStart.delegate = self
        dateFinish.delegate = self
        cityField.delegate = self
    }
    func configButton() {
        searchButton.layer.borderWidth = 2
        searchButton.layer.cornerRadius = 3
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func changeDate(startDate:Bool, date:NSDate) {
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        formatter.locale = NSLocale(localeIdentifier: "ru_RU")
        
        let dateString = formatter.stringFromDate(date)
        if startDate == true {
            dateStart.text = dateString
        } else {
            let dates = formatter.dateFromString(dateStart.text!)?.timeIntervalSince1970 > formatter.dateFromString(dateFinish.text!)?.timeIntervalSince1970
            print(dates)
            if dates || dateStart.text == ""{
                dateFinish.text = dateString
            } else {
                dateFinish.text = ""
            }
        }
    }
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.tag == 1 {
            performSegueWithIdentifier("showStartDatePicker", sender: nil)
        } else if textField.tag == 2 {
            performSegueWithIdentifier("showFinishDatePicker", sender: nil)

        }
    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField.tag != 1 && textField.tag != 2 {
//Не инициализируется гугл плейсиз ключ, там вроде надо подождать какое-то время, так что пока без автокомплита
//            placeAutocomplete(textField.text!)
        }
        return true
    }
    func placeAutocomplete(text:String) {
        placesClient = GMSPlacesClient.sharedClient()

        let filter = GMSAutocompleteFilter()
        filter.type = GMSPlacesAutocompleteTypeFilter.City
        filter.country = "Russia"

        dispatch_sync(dispatch_get_global_queue(
            Int(QOS_CLASS_USER_INTERACTIVE.rawValue), 0)) {
                self.placesClient?.autocompleteQuery(text, bounds: nil, filter: filter, callback: { (results, error: NSError?) -> Void in
                    if let error = error {
                        print("Autocomplete error \(error)")
                    }
                    if results != nil {
                        for result in results! {
                            
                            print("Result \(result.attributedFullText) with placeID \(result.placeID)")
                        }
                        dispatch_async(dispatch_get_main_queue(),{
                            
//                            self.table.reloadData()
                        })
                        
                    }
                })
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let viewController = segue.destinationViewController as? ModalDatePickerViewController {
            viewController.delegate = self
            if segue.identifier == "showStartDatePicker" {
                viewController.startDate = true
            } else if segue.identifier == "showFinishDatePicker"{
                viewController.startDate = false
            }
        }
        if segue.identifier == "showHotels" {
            if let viewController = segue.destinationViewController as? HotelsTableViewController {
                viewController.tableHotelsSource = sourceTableHotels
            }
    
        }
    }


}
