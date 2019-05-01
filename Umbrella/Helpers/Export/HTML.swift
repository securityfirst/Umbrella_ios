//
//  Html.swift
//  Umbrella
//
//  Created by Lucas Correa on 22/01/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation
import Down

class HTML: ExportProtocol {
    
    //
    // MARK: - Properties
    let nameFile: String!
    var content: String!
    
    //
    // MARK: - Initializer
    
    /// Init
    ///
    /// - Parameters:
    ///   - nameFile: String
    ///   - content: String
    init(nameFile: String, content: String) {
        self.nameFile = nameFile
        self.content = content
    }
    
    /// Create File export
    ///
    /// - Returns: URL
    func createExport() -> URL {
        do {
            if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL = documentDirectory.appendingPathComponent(self.nameFile)
                try self.content.write(to: fileURL, atomically: false, encoding: .utf8)
                
                return fileURL
            }
        } catch {
            print("error:", error)
        }
        
        return URL(string: "")!
    }
    
    /// Prepare html with style of the content
    ///
    /// - Returns: String
    func prepareHtmlWithStyle() {
        do {
            var html = try Down(markdownString: self.content).toHTML()
            
            html = """
            <meta http-equiv="content-type" content="text/html;charset=utf-8">
            <html>
                <head>
                    <style>
                        body{
                            color:#444444;
                            font-size:300%;
                            padding: 50px 50px 50px 50px; 
                        }
                        img{
                            width:100%
                        }
                        h1{
                            color:#33b5e5;
                            font-weight:normal;
                        }
                        h2{
                            color:#9ABE2E;
                            font-weight:normal;
                        }
                        getDifficultyFromId{
                            color:#33b5e5
                        }
                        .button,.button:link{
                            display:block;
                            text-decoration:none;
                            color:white;
                            border:none;
                            width:100%;
                            text-align:center;
                            border-radius:3px;
                            padding-top:10px;
                            padding-bottom:10px;
                        }
                        .green{
                            background:#9ABE2E
                        }
                        .purple{
                            background:#b83656
                        }
                        .yellow{
                            background:#f3bc2b
                        }
                    </style>
                </head>
                <body>
                \(html)
                </body>
            </html>
            """
            self.content = html
        } catch {
            print("Convert to html error: \(error)")
        }
    }
}
