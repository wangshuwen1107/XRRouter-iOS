//
//  Book.swift
//  XRRouter_Example
//
//  Created by 王书文 on 2020/10/9.
//  Copyright © 2020 wnwn7375@outlook.com. All rights reserved.
//

import Foundation
class Book: NSObject {
    
    @objc var bookName:String

    init(_ name:String) {
        self.bookName = name
    }

    override var description: String { return "Book: \(bookName)" }
}
