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

        return p1.merge(with: p2).eraseToAnyPublisher()
    }
}


extension UITextView: RequiredProperty
{
    public var isFilled: Bool
    {
        return (self.text?.count ?? 0) > 0
    }
    
    public var isFilledPublisher: AnyPublisher<Bool, Never>
    {
        return self.publisher(for: \.text).map { ($0?.count ?? 0) > 0 }.eraseToAnyPublisher()
    }
}


extension UIButton: RequiredProperty
{
    public var propertyName: String
    {
        return self.title(for: .normal) ?? ""
    }
    
    public var isFilled: Bool
    {
        return self.isSelected
    }
    
    public var isFilledPublisher: AnyPublisher<Bool, Never>
    {
        return self.publisher(for: \.isSelected).eraseToAnyPublisher()
    }
}


extension UISwitch: RequiredProperty
{
    public var propertyName: String
    {
        if #available(iOS 14, *)
        {
            return self.title ?? ""
        }
        
        return ""
    }
    
    public var isFilled: Bool
    {
        return self.isOn
    }
    
    public var isFilledPublisher: AnyPublisher<Bool, Never>
    {
        return self.publisher(for: \.isOn).eraseToAnyPublisher()
    }
}


extension UISegmentedControl: RequiredProperty
{
    public var isFilled: Bool
    {
        return self.selectedSegmentIndex >= 0
    }
    
    public var isFilledPublisher: AnyPublisher<Bool, Never>
    {
        return self.publisher(for: \.selectedSegmentIndex).map { $0 >= 0 }.eraseToAnyPublisher()
    }
}
