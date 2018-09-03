//
//  ImageDownloadSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 03/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class ImageDownloadSpec: QuickSpec {
    
    override func spec() {
        describe("ImageDownload") {
            
            beforeEach {
                
            }
            
            it("should create a new ImageDownload") {
                let download = ImageDownload()
                expect(download).toNot(beNil())
            }
            
            it("should do a download of an image from a URL") {
                let download = ImageDownload()
                let url = URL(string: "https://via.placeholder.com/350x150")
                waitUntil(timeout: 600) { done in
                 
                    download.downloadImageFrom(url: url!, completion: { image in
                        expect(image).toNot(beNil())
                        done()
                    })
                }
            }
            
            it("should do a download of an image from a URLString") {
                let download = ImageDownload()
                let url = "https://via.placeholder.com/350x150"
                waitUntil(timeout: 600) { done in
                    
                    download.downloadImageFrom(urlString: url, completion: { image in
                        expect(image).toNot(beNil())
                        done()
                    })
                }
            }
            
            afterEach {
                
            }
        }
    }
}
