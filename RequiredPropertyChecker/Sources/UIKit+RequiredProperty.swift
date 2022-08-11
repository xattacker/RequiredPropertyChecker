//
//  UIKit+RequiredProperty.swift
//  RequiredPropertyChecker
//
//  Created by xattacker on 2021/8/21.
//  Copyright © 2021 xattacker. All rights reserved.
//

import UIKit
import Combine


extension UITextField: RequiredProperty
{
    public var isFilled: Bool
    {
        return (self.text?.count ?? 0) > 0
    }
    
    public var isFilledPublisher: AnyPublisher<Bool, Never>
    {
        let p1 = NotificationCenter.default
                   .publisher(for: UITextField.textDidChangeNotification, object: self)
                   .map { (($0.object as? UITextField)?.text?.count ?? 0) > 0 }

        let p2 = self.publisher(for: \.text).map { ($0?.count ?? 0) > 0 }
        
        return Publishers.Merge(p1, p2).eraseToAnyPublisher()
    }
}


//extension UITextView: RequiredProperty
//{
//    public var isFilled: Bool
//    {
//        return (self.text?.count ?? 0) > 0
//    }
//    
//    public var isFilledBinding: Driver<Bool>
//    {
//        return self.rx.text.map { $0?.count ?? 0 > 0 }.asDriver(onErrorJustReturn: false)
//    }
//}
//
//
//extension UISwitch: RequiredProperty
//{
//    public var propertyName: String
//    {
//        if #available(iOS 14, *)
//        {
//            return self.title ?? ""
//        }
//        
//        return ""
//    }
//    
//    public var isFilled: Bool
//    {
//        return self.isOn
//    }
//    
//    public var isFilledBinding: Driver<Bool>
//    {
//        return self.rx.isOn.asDriver()
//    }
//}
//
//
//extension UISegmentedControl: RequiredProperty
//{
//    public var isFilled: Bool
//    {
//        return self.selectedSegmentIndex >= 0
//    }
//    
//    public var isFilledBinding: Driver<Bool>
//    {
//        return self.rx.selectedSegmentIndex.map { $0 >= 0 }.asDriver(onErrorJustReturn: false)
//    }
//}
