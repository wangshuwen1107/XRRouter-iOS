//
//  TestModule.swift
//  dingstock
//
//  Created by 王书文 on 2020/9/4.
//  Copyright © 2020 cn.cheney. All rights reserved.
//

import Foundation


class TestModule: NSObject, XRRouterProtocol {

    class func moduleName() -> String {
        "test"
    }

    class func registerMethod(_ module: XRRouterModule) {
        module.newMethod { (method) in
            method.methodName = "getBookName"
            method.params({ (builder) in
                builder.newParam("name", .string)
                builder.newParam("pageNum", .number)
                builder.newParam("listParam", .array)
                builder.newParam("mapParam", .map)
            })
            method.selector = #selector(getBook(name:pageNum:listParam:mapParam:))
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
        
    }

    @objc static func getBook(name: String,
                           pageNum: NSNumber,
                           listParam: [NSString],
                           mapParam:[String:String]) -> Book {
        print("getBookName is called name =\(name) pageNum =\(pageNum) listParam=\(listParam) map=\(mapParam)")
        return Book(name)
    }
    
    @objc func getAsyncBook(requestId:String,name:String) {
        print("getAsyncBook is called requestId=\(requestId) name=\(name)")
        XRRouter.share().callback(requestId, ["name":name])
    }
}


