# ResultBuilderKit

## ArrayBuilder

To create an array from blocks and expressions

```swift
let array: [MyElement] = buildArray {
  
  constants
  
  if flag {
    option
  }
  
  additionalElement
  
}
```

or 
```swift

func doSomething(@ArrayBuilder<String> _ value: () -> [String]) {
  let array: [String] = value()
  ...
}
```
