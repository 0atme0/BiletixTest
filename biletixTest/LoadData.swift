//
//  LoadData.swift
//  biletixTest
//
//  Created by Andrey Ildyakov on 10.01.17.
//  Copyright © 2017 Andrey Ildyakov. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class LoadData {
    private func configRequest(city:String, accommodationArrival:NSDate, accommodationDeparture:NSDate) -> NSMutableURLRequest {
        let url = NSURL.init(string: "https://hotels.gate.biletix.ru/hotels/test/searchResultStat?apiKey=0b85bbb1a4c09536768e9c81161bf24a")
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//Работает только Самара
        let newCityString = "Самара (Россия)"
        let values = [
            "requests" : [[
                "indexName":"airbnb",
                "params":"query=\(newCityString.encodeUrl())&hitsPerPage=10&maxValuesPerFacet=10&page=0&facets=%5B%22stars%22%2C%22room_type%22%2C%22facilities%22%2C%22price%22%5D&tagFilters=&numericFilters=[\"AccommodationArrival=\(Int(accommodationArrival.timeIntervalSince1970))\",\"AccommodationDeparture=\(Int(accommodationDeparture.timeIntervalSince1970))\"]"
                ]]
        ]
        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(values, options: [])
        return request
    }
    
    func postRequest(city:String, accommodationArrival:NSDate, accommodationDeparture:NSDate, completion: ([HotelModel])->()) {
        let request = configRequest(city, accommodationArrival: accommodationArrival, accommodationDeparture: accommodationDeparture)
//send request
        
        Alamofire.request(request).validate().responseJSON { response in
            switch response.result{
            case .Success:
                
                guard response.result.error == nil else {
                    return
                }
                
                if let value = response.result.value {
                    let json = JSON(value)
                    var hotelsArray : [HotelModel] = []
                    for (_,subJson):(String, SwiftyJSON.JSON) in json["results"]{
                        for (_,subsubJson):(String, SwiftyJSON.JSON) in subJson["hits"] {
                            let hotelOne = HotelModel()

                                hotelOne.hotelName = subsubJson["description"]["name"]["value"].stringValue
                            hotelOne.hotelPrice = subsubJson["price_formatted"].stringValue

                            hotelOne.hotelImage = subsubJson["thumbnail_url"].stringValue
                    hotelsArray.append(hotelOne)
                        }
                    }
                    completion(hotelsArray)
                }
                
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    
    
}
