//
//  Extension.swift
//  biletixTest
//
//  Created by Andrey Ildyakov on 11.01.17.
//  Copyright © 2017 Andrey Ildyakov. All rights reserved.
//

import Foundation
extension String
{
    func encodeUrl() -> String
    {
        return self.stringByAddingPercentEncodingWithAllowedCharacters( NSCharacterSet.URLQueryAllowedCharacterSet())!
    }
    func decodeUrl() -> String
    {
        return self.stringByRemovingPercentEncoding!
    }
    
}
