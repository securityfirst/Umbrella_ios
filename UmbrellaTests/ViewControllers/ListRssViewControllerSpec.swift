//
//  ListRssViewControllerSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 03/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble
import FeedKit

@testable import Umbrella

class ListRssViewControllerSpec: QuickSpec {
    
    override func spec() {
        var viewController: ListRssViewController!
        let window = UIWindow(frame: UIScreen.main.bounds)
        let viewModel = RssViewModel()
        
        beforeEach {
            let storyboard = UIStoryboard(name: "Feed",
                                          bundle: Bundle.main)
            viewController = storyboard.instantiateViewController(withIdentifier: "ListRssViewController") as? ListRssViewController
            
            window.makeKeyAndVisible()
            window.rootViewController = viewController
            viewController.beginAppearanceTransition(true, animated: false)
            viewController.endAppearanceTransition()
        }
        
        describe("ListRssViewController") {
            describe(".viewDidLoad") {
                it ("should be presented") {
                    window.rootViewController?.viewDidLoad()
                    expect(window.rootViewController).toEventually(beAnInstanceOf(ListRssViewController.self), timeout: 5.5, pollInterval: 0.2)
                }
            }
            
            describe("tableview") {
                it ("should be a List cell valid") {
                    viewController.loadViewIfNeeded()
                    let cell = viewController.listRssTableView.dequeueReusableCell(withIdentifier: "ListRssCell")
                    expect(cell).toNot(beNil())
                }
                
                it ("should be a List cell valid - cellForRowAt") {
                    viewController.loadViewIfNeeded()
                    
                    waitUntil(timeout: 30) { done in
                        
                        viewModel.loadRSS(feeds: [["url": "http://feeds.bbci.co.uk/news/world/rss.xml?edition=uk"]], completion: {
                            let result = viewModel.rssArray.first
                            viewController.listRssViewModel.items = (result?.result.rssFeed?.items)!
                            let cell = viewController.tableView(viewController.listRssTableView, cellForRowAt: IndexPath(row: 0, section: 0))
                            expect(cell).toNot(beNil())
                            done()
                        })
                    }
                }
                
                it ("should be a Card cell valid") {
                    viewController.loadViewIfNeeded()
                    viewController.rssModeView = 1
                    let cell = viewController.listRssTableView.dequeueReusableCell(withIdentifier: "CardRssCell")
                    expect(cell).toNot(beNil())
                }
                
                it ("should be a Card cell valid - cellForRowAt") {
                    viewController.loadViewIfNeeded()
                    viewController.rssModeView = 1
                    waitUntil(timeout: 30) { done in
                        
                        viewModel.loadRSS(feeds: [["url": "http://feeds.bbci.co.uk/news/world/rss.xml?edition=uk"]], completion: {
                            let result = viewModel.rssArray.first
                            viewController.listRssViewModel.items = (result?.result.rssFeed?.items)!
                            let cell = viewController.tableView(viewController.listRssTableView, cellForRowAt: IndexPath(row: 0, section: 0))
                            expect(cell).toNot(beNil())
                            done()
                        })
                    }
                }
                
                it ("should be a cell inValid") {
                    viewController.loadViewIfNeeded()
                    let cell = viewController.listRssTableView.dequeueReusableCell(withIdentifier: "Cell")
                    expect(cell).to(beNil())
                }
            }
        }
    }
}
