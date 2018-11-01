//
//  LoadingViewModelSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 04/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class LoadingViewModelSpec: QuickSpec {
    
    override func spec() {
        describe("LoadingViewModel") {
            
            let loadingViewModel = LoadingViewModel()
            
            beforeEach {
                
                let url = "https://github.com/klaidliadon/umbrella-content"
                UserDefaults.standard.set(url, forKey: "gitHubDemo")
                UserDefaults.standard.synchronize()
            }
            
            it("should do the clone of the tent") {
                Config.debug = false
                waitUntil(timeout: 600) { done in
                    loadingViewModel.clone(witUrl: Config.gitBaseURL, completion: { progress in
                        if progress == 1.0 {
                            expect(progress).to(equal(1.0))
                            done()
                        }
                    }, failure: { error in
                        print("GitManager: \(error)")
                    })
                }
            }
            
            it("should do the parse of the tent") {
                Config.debug = false
                waitUntil(timeout: 30) { done in
                    loadingViewModel.parseTent(completion: { progress in
                        if progress == 1.0 {
                            expect(progress).to(equal(1.0))
                            done()
                        }
                    })
                }
            }
            
//            it("should be languages and form loaded of the database") {
//                Config.debug = false
//                loadingViewModel.loadUmbrellaOfDatabase()
//
//                expect(loadingViewModel.languages.count).to(equal(1))
//                expect(loadingViewModel.forms.count).to(equal(4))
//            }
            
            it("should check if exist clone of the tent") {
                Config.debug = false
                let success = loadingViewModel.checkIfExistClone(pathDirectory: .documentDirectory)
                expect(success).to(beTrue())
            }
            
            afterEach {
                
            }
        }
    }
}
