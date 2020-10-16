//
//  NSSObject_Exrt.swift
//  dingstock
//
//  Created by 梅映雪 on 2020/9/6.
//  Copyright © 2020 cn.cheney. All rights reserved.
//

import Foundation

extension NSObject {
    // create a static method to get a swift class for a string name
    class func swiftClassFromString(className: String) -> AnyClass! {
        // get the project name
        if  let appName: String? = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String? {
            let classStringName = "\(appName ?? "").\(className)"
            return NSClassFromString(classStringName)
        }
        return nil;
    }
}
