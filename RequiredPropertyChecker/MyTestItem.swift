//
//  MyTestItem.swift
//  RequiredPropertyChecker
//
//  Created by xattacker.tao on 2022/8/22.
//  Copyright © 2022 xattacker. All rights reserved.
//

import Foundation
import Combine


class MyTestItem
{
    @Published
    var text: String?
}


extension MyTestItem: RequiredProperty
{
    public var isFilled: Bool
    {
        return (self.text?.count ?? 0) > 0
    }
    
    public var isFilledPublisher: AnyPublisher<Bool, Never>
    {
        return self.$text.map { _ in self.isFilled }.eraseToAnyPublisher()
    }
}
