//
//  ChatViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 07/06/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import UIKit
import Localize_Swift

class ChatViewController: UIViewController {

    //
    // MARK: - Properties
    var navigationItemCustom: NavigationItemCustom!
    var chatSignInViewController: ChatSignInViewController!
    lazy var chatCredentialViewModel: ChatCredentialViewModel = {
        let chatCredentialViewModel = ChatCredentialViewModel()
        return chatCredentialViewModel
    }()
    lazy var chatGroupViewModel: ChatGroupViewModel = {
        let chatGroupViewModel = ChatGroupViewModel()
        return chatGroupViewModel
    }()
    @IBOutlet weak var chatGroupCollectionView: UICollectionView!
    
    //
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.title = "Chat".localized()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItemCustom = NavigationItemCustom(viewController: self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateLanguage), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(removeCredentialScreen), name: NSNotification.Name("RemoveCredentialScreen"), object: nil)
    }
    
    fileprivate func loadPublicRooms() {
        if let userMatrix = self.chatCredentialViewModel.getUserLogged() {
            self.chatGroupViewModel.publicRooms(accessToken: userMatrix.accessToken, success: { (publicRoom) in
                self.chatGroupCollectionView.reloadData()
            }, failure: { (response, object, error) in
                print(error ?? "")
            })
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItemCustom.showItems(true)
        
        if !self.chatCredentialViewModel.isLogged() {
            let storyboard = UIStoryboard(name: "Chat", bundle: Bundle.main)
            self.chatSignInViewController = (storyboard.instantiateViewController(withIdentifier: "ChatSignInViewController") as? ChatSignInViewController)!
            self.add(self.chatSignInViewController)
            self.navigationItem.rightBarButtonItem = nil
        } else {
            let modeBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(self.newMessage))
            self.navigationItem.rightBarButtonItem  = modeBarButton
            
            loadPublicRooms()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItemCustom.showItems(false)
    }
    
    //
    // MARK: - Functions
    
    @objc func newMessage() {
        self.title = "Chat".localized()
    }
    
    @objc func updateLanguage() {
        self.title = "Chat".localized()
    }
    
    @objc func removeCredentialScreen() {
        self.children.forEach({
            $0.willMove(toParent: nil)
            $0.view.removeFromSuperview()
            $0.removeFromParent()
        })
        
        let modeBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(self.newMessage))
        self.navigationItem.rightBarButtonItem  = modeBarButton
        
        loadPublicRooms()
    }
    
    @objc func chatGroupHeaderDidSelect(gesture: UIGestureRecognizer) {
//        let view:ChatGroupReusableView = (gesture.view as? ChatGroupReusableView)!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "messageSegue" {
            let chatMessageViewController = (segue.destination as? ChatMessageViewController)!
            
            let publicChunk = (sender as? PublicChunk)!
            chatMessageViewController.chatMessageViewModel.userLogged = self.chatCredentialViewModel.getUserLogged()
            chatMessageViewController.chatMessageViewModel.room = publicChunk
        }
    }
    
    //
    // MARK: - Actions
}

extension ChatViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let publicChunk = self.chatGroupViewModel.rooms[indexPath.row]
        self.performSegue(withIdentifier: "messageSegue", sender: publicChunk)
    }
}

extension ChatViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.chatGroupViewModel.rooms.count > 5 ? 5 : self.chatGroupViewModel.rooms.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ChatGroupCell = (collectionView.dequeueReusableCell(withReuseIdentifier: "ChatGroupCell", for: indexPath) as? ChatGroupCell)!
        cell.configure(withViewModel: self.chatGroupViewModel, indexPath: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeaderView = (collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ChatGroupReusableView", for: indexPath) as? ChatGroupReusableView)!
        sectionHeaderView.indexPath = indexPath
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.chatGroupHeaderDidSelect(gesture:)))
        sectionHeaderView.addGestureRecognizer(tap)
            return sectionHeaderView
    }

}
