//
//  GitManagerSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 12/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class GitManagerSpec: QuickSpec {
    
    override func spec() {
        
        beforeEach {
            
        }
        
        describe("GitManager") {
            xit("should create a clone of a repository") {
                waitUntil(timeout: 600) { done in
                    let url = Config.gitBaseURL

                    Config.debug = false
                    let gitManager = GitManager(url: url, pathDirectory: .downloadsDirectory)
                    gitManager.clone(completion: { (totalBytesWritten, totalBytesExpectedToWrite) in
                        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)

                        if progress == 1 {
                            expect(progress).to(equal(1))
                            done()
                        }
                    }, failure: { error in
                        print(error)
                        done()
                    })
                }
            }

            it("should remove the folder of the clone") {
                let url = Config.gitBaseURL

                do {

                    Config.debug = false
                    let gitManager = GitManager(url: url, pathDirectory: .downloadsDirectory)
                    try gitManager.deleteCloneInFolder(pathDirectory: gitManager.pathDirectory)

                    let documentsUrl = gitManager.fileManager.urls(for: .downloadsDirectory,
                                                        in: .userDomainMask)

                    let filePaths = try gitManager.fileManager.contentsOfDirectory(at: documentsUrl.first!, includingPropertiesForKeys: nil)

                    expect(filePaths).to(beEmpty())
                } catch {
                    print(error)
                }
            }

            it("should create a clone of a repository that doesn't exist") {
                waitUntil(timeout: 600) { done in
                    let url = URL(string: "http://securityfirst.org")

                    Config.debug = false
                    let gitManager = GitManager(url: url!, pathDirectory: .downloadsDirectory)
                    gitManager.clone(completion: { (_, _) in
                    }, failure: { error in
                        expect(error).notTo(beNil())
                        done()
                    })
                }
            }
            
            it("should test the catch of the method deleteCloneInFolder") {
                waitUntil(timeout: 600) { done in
                    let url = URL(string: "http://securityfirst.org")
                    
                    Config.debug = false
                    let gitManager = GitManager(url: url!, pathDirectory: .adminApplicationDirectory)
                    gitManager.clone(completion: { (_, _) in
                    }, failure: { error in
                        expect(error).notTo(beNil())
                        done()
                    })
                }
            }
        }
        
        afterEach {
            
        }
    }
}
