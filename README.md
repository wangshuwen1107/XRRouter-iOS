![](media/XRRouter.png)

# XRRouter

[![Version](https://img.shields.io/cocoapods/v/XRRouter.svg?style=flat)](https://cocoapods.org/pods/XRRouter)
[![License](https://img.shields.io/cocoapods/l/XRRouter.svg?style=flat)](https://cocoapods.org/pods/XRRouter)
[![Platform](https://img.shields.io/cocoapods/p/XRRouter.svg?style=flat)](https://cocoapods.org/pods/XRRouter)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

XRRouter is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'XRRouter'
```

## Instructions
url : `scheme://moduleName/methodName?key=value`
* 支持数据类型 Number,String,Array,Map
* url后面拼接参数,如果涉及到Array,Map,需要encode value
* 保证XRRouterProtocol协议遵循者必须有空构造函数

## Use
1.Init（application didFinishLaunching）
 ```swift
XRRouter.setup("scheme")
XRRouter.share().errorHandler({ (url, errorMsg) in
    // do error
})
XRRouter.share()?.addInterceptor({intent in
    // do interceptor
    return intent;
})
 ```
2.Register
 ```swift

class TestModule: NSObject, XRRouterProtocol {

    class func moduleName() -> String {
        "test"
    }

    class func registerMethod(_ module: XRRouterModule) {
        module.newMethod { (method) in
            method.methodName = "getBookName"
            method.params({ (builder) in
                builder.newParam("name", .string)
            })
            method.selector = #selector(getBook(name:))
            method.returnType = .object
        }
        module.newMethod { (method) in
            method.methodName = "getAsyncBook"
            method.params({ (builder) in
                builder.requestId()
                builder.newParam("name", .string)
            })
            method.selector = #selector(getAsyncBook(requestId:name:))
            method.returnType = .empty
        }

    @objc static func getBook(name: String) -> Book {
        return Book(name)
    }
    
    @objc func getAsyncBook(requestId:String,name:String) {
        XRRouter.share().callback(requestId, ["name":name])
    }
}
 ```
3.Route
 ```swift
  //sync
  let returnValue = XRRouter
         .share()
         .url("test/getBookName")?
         .param("name", "swift")
         .start()
  //Async
  XRRouter.share()
         .url("dc://test/getAsyncBook")?
         .param("name", "swift")
         .startAsync { result in
         }
 ```

## Author

wnwn7375@outlook.com

## License

XRRouter is available under the MIT license. See the LICENSE file for more info.
