//
//  PDFFactory.swift
//  Umbrella
//
//  Created by Lucas Correa on 21/01/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation
import UIKit

struct PDFFactory {
    
    /// Create a pdf with text
    ///
    /// - Parameters:
    ///   - text: String
    ///   - pdfURL: URL
    static func createPDF(text: String, pdfURL: URL) {
        let fmt = UIMarkupTextPrintFormatter(markupText: text)
        
        let render = UIPrintPageRenderer()
        render.addPrintFormatter(fmt, startingAtPageAt: 0)
        let page = CGRect(x: 0, y: 0, width: 595.2, height: 841.8) // A4, 72 dpi
        render.setValue(page, forKey: "paperRect")
        render.setValue(page, forKey: "printableRect")
        
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, .zero, nil)
        for index in 0..<render.numberOfPages {
            UIGraphicsBeginPDFPage()
            render.drawPage(at: index, in: UIGraphicsGetPDFContextBounds())
        }
        
        UIGraphicsEndPDFContext()
        pdfData.write(to: pdfURL, atomically: true)
    }
}
