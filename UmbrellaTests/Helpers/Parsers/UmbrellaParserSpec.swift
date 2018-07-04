//
//  UmbrellaParserSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 18/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Files

@testable import Umbrella

class UmbrellaParserSpec: QuickSpec {
    
    override func spec() {
        
        let tentBundleFolder: Folder = {
            var documents: Folder?
            do {
                if let bundle = Bundle(for: type(of: self)).path(forResource: "Tent", ofType: "bundle") {
                    let folder = try Folder(path: bundle)
                    documents = folder
                }
            } catch {
                print(error)
            }
            return documents!
        }()
        
        beforeEach {
            
        }
        
        describe("UmbrellaParser") {
            it("should do the parser of the tent") {
                waitUntil(timeout: 60) { done in
                    var umbrellaParser = UmbrellaParser(documentsFolder: tentBundleFolder)
                    umbrellaParser.parse(completion: { languages, forms in
                        expect(languages.count).to(equal(1))
                        expect(languages.first?.categories.count).to(equal(9))
                        expect(forms.count).to(equal(4))
                        done()
                    })
                }
            }
        }
        
        afterEach {
            
        }
    }
}
