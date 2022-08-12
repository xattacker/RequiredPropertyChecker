# RequiredPropertyChecker
a Swift Combine Related component, help checking property has been filled

another congeneric project: https://github.com/xattacker/RxRequiredPropertyChecker
<br>(which implemented by RxSwift)


https://user-images.githubusercontent.com/33754378/131239984-9138ccfd-5525-4584-8b8c-712079140315.mp4


# Installation

### Cocoapods
RequiredPropertyChecker can be added to your project using CocoaPods 0.36 or later by adding the following line to your Podfile:
```
pod 'RequiredPropertyChecker'
```

### Swift Package Manager
To add RequiredPropertyChecker to a [Swift Package Manager](https://swift.org/package-manager/) based project, add:

```swift
.package(url: "https://github.com/xattacker/RequiredPropertyChecker.git", .upToNextMajor(from: "1.0.0")),
```
to your `Package.swift` files `dependencies` array.


### How to use:
``` 
import RequiredPropertyChecker
import Combine

// make the component implement protocol RequiredProperty
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


// then add the component instance into RxRequiredPropertyChecker
let textField: UITextField
var set = Set<AnyCancellable>()
    
let checker = RequiredPropertyChecker()
checker.add(textField)

// bind checker with other
checker.$isFilled           
            .sink {
                [weak self]
                filled in
                self?.button.isEnable = filled
            }.store(in: &set)
``` 
