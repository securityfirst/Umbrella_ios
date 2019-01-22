//
//  Export.swift
//  Umbrella
//
//  Created by Lucas Correa on 22/01/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation

class Export {
    
    //
    // MARK: - Properties
    let exportProtocol: ExportProtocol!
    
    //
    // MARK: - Initializer
    
    /// Init
    ///
    /// - Parameter exportProtocol: ExportProtocol
    init( _ exportProtocol: ExportProtocol) {
        self.exportProtocol = exportProtocol
    }
    
    //
    // MARK: - Functions
    
    /// Make export to PDF or HTML
    ///
    /// - Returns: URL
    func makeExport() -> URL {
        return self.exportProtocol.createExport()
    }
}
