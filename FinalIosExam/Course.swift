//
//  Course.swift
//  Course
//
//  Created by Shubham Behal on 04/11/21.
//

import Foundation
class Course{
    var name: String
    var hours: Int
    var fee: Int
    
    init(name: String,hours: Int,fee: Int)
    {
        self.name = name
        self.hours = hours
        self.fee = fee
    }
}
