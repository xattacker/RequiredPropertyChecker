//
//  ViewController.swift
//  RequiredPropertyChecker
//
//  Created by tao on 2021/8/20.
//  Copyright © 2018年 xattacker. All rights reserved.
//

import UIKit
import Combine


class ViewController: UIViewController
{
    @IBOutlet private weak var textFiled: UITextField!
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var switchView: UISwitch!
    @IBOutlet private weak var segmentCtrl: UISegmentedControl!
    
    @IBOutlet private weak var isFilledLabel: UILabel!
    
    private let myItem = MyTestItem()
    
    private let propertyChecker = RequiredPropertyChecker()

    private var set = Set<AnyCancellable>()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
 
        self.propertyChecker.add(self.textFiled, self.textView, self.switchView, self.segmentCtrl, self.myItem)
        
        self.propertyChecker.$isFilled.map { $0 ? "isAllFilled" : "notAllFilled" }
            .sink {
                [weak self]
                text in
                self?.isFilledLabel.text = text
            }.store(in: &set)
        
        self.propertyChecker.$isFilled.map { $0 ? UIColor.blue : UIColor.red }
            .sink {
                [weak self]
                color in
                self?.isFilledLabel.textColor = color
            }.store(in: &set)
    }

    @IBAction func onTextFiledAction(_ obj: AnyObject)
    {
        // test TextFiled text setting by code
        self.textFiled.text = "aaaaa"
    }
    
    @IBAction func onTextViewAction(_ obj: AnyObject)
    {
        // test TextView text setting by code
        self.textView.text = "bbbbb"
    }
    
    @IBAction func onRemovePropertyAction(_ obj: AnyObject)
    {
        _ = self.propertyChecker.remove(self.switchView)
    }
    
    @IBAction func onClearPropertyAction(_ obj: AnyObject)
    {
        self.propertyChecker.clear()
    }
    
    @IBAction func onFillMyItemAction(_ obj: AnyObject)
    {
        self.myItem.text = "11123"
    }
}
