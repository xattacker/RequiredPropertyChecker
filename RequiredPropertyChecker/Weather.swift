//
//  Weather.swift
//  RequiredPropertyChecker
//
//  Created by xattacker.tao on 2022/8/1.
//  Copyright © 2022 xattacker. All rights reserved.
//

import Foundation
import Combine


class Weather: WeatherP
{
    @Published
    var value: Int?
    
    var valueBinding: Published<Int?>.Publisher { $value }
}


protocol WeatherP
{
    var valueBinding: Published<Int?>.Publisher { get }
}
