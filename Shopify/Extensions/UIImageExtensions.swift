//
//  UIImageExtensions.swift
//  Shopify
//
//  Created by Kaori Persson on 2022-04-14.
//

import UIKit

extension UIImage {
    public convenience init(url: URL) {
        do {
            let data = try Data(contentsOf: url)
            self.init(data: data)!
            return
        } catch let err {
            print("Error : \(err.localizedDescription)")
        }
        self.init()
    }
}
