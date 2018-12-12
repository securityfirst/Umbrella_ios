//
//  UIPrintPageRenderer-Extensions.swift
//  HTMLPDFRenderer
//
//  Copyright © 2015 Aleksandar Vacić, Radiant Tap
//	https://github.com/radianttap/HTML2PDFRenderer
//
//  MIT License · http://choosealicense.com/licenses/mit/
//

import UIKit

extension UIPrintPageRenderer {
    public func makePDF() -> Data {
        let data = NSMutableData()
        
        UIGraphicsBeginPDFContextToData(data, paperRect, nil)
        prepare(forDrawingPages: NSRange(location: 0, length: numberOfPages))
        let bounds = UIGraphicsGetPDFContextBounds()
        
        for index in 0 ..< numberOfPages {
            UIGraphicsBeginPDFPage()
            drawPage(at: index, in: bounds)
        }
        UIGraphicsEndPDFContext()
        
        return data as Data
    }
}
