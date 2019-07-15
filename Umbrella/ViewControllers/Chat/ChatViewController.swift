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
    
    fileprivate lazy var chatClientViewModel: ChatClientViewModel = {
        let chatClientViewModel = ChatClientViewModel()
        return chatClientViewModel
    }()
    
    @IBOutlet weak var chatGroupCollectionView: UICollectionView!
    var addBarButtonItem: UIBarButtonItem!
    var loadRoomsCount = 0
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItemCustom.showItems(true)
        
        if !self.chatCredentialViewModel.isLogged() {
            let storyboard = UIStoryboard(name: "Chat", bundle: Bundle.main)
            self.chatSignInViewController = (storyboard.instantiateViewController(withIdentifier: "ChatSignInViewController") as? ChatSignInViewController)!
            self.add(self.chatSignInViewController)
            self.navigationItem.rightBarButtonItem = nil
        } else {
            self.addBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(self.newMessage))
            self.navigationItem.rightBarButtonItem  = self.addBarButtonItem
            
            self.chatGroupViewModel.userLogged = self.chatCredentialViewModel.getUserLogged()
            loadRooms()
        }
        
        self.view.tag = 999
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItemCustom.showItems(false)
        self.loadRoomsCount = 0
    }
    
    //
    // MARK: - Functions
    
    fileprivate func loadPublicRooms() {
        self.chatGroupViewModel.publicRooms(success: { (publicRoom) in
            self.loadRoomsCount+=1
        }, failure: { (response, object, error) in
            self.loadRoomsCount+=1
            print(error ?? "")
        })
    }
    
    fileprivate func loadJoinedRooms() {
        self.chatClientViewModel.sync(success: { (joinedRooms) in
            self.loadRoomsCount+=1
        }, failure: { (response, object, error) in
            self.loadRoomsCount+=1
            print(error ?? "")
        })
    }
    
    fileprivate func loadRooms() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller = (storyboard.instantiateViewController(withIdentifier: "LoadingViewController") as? LoadingViewController)!
        if self.view.tag != 999 {
            controller.showLoading(view: self.view)
        }
        
        let concurrent = DispatchQueue(label: "Concurrent Queue", attributes: .concurrent)
        concurrent.async {
            self.loadPublicRooms()
            self.loadJoinedRooms()
            
            while self.loadRoomsCount < 2 {
                if self.loadRoomsCount == 2 {
                    DispatchQueue.main.async {
                        
                        print(self.chatClientViewModel.rooms.count)
                        print(self.chatGroupViewModel.rooms.count)
                        self.chatClientViewModel.removePublicRooms(publicRoomList: self.chatGroupViewModel.rooms)
                        controller.closeLoading()
                        self.chatGroupCollectionView.reloadData()
                    }
                    self.loadRoomsCount = 0
                    break
                }
            }
        }
    }
    
    @objc func newMessage() {
        self.title = "Chat".localized()
        
        let storyboard = UIStoryboard(name: "Chat", bundle: Bundle.main)
        let chatNewItemViewController = (storyboard.instantiateViewController(withIdentifier: "ChatNewItemViewController") as? ChatNewItemViewController)!
        chatNewItemViewController.modalPresentationStyle = .popover
        chatNewItemViewController.preferredContentSize = CGSize(width: 200, height: 135)
        
        let presentationController = (chatNewItemViewController.presentationController as? UIPopoverPresentationController)!
        presentationController.delegate = self
        //        presentationController.backgroundColor = #colorLiteral(red: 0.5934140086, green: 0.7741840482, blue: 0.2622931898, alpha: 1)
        presentationController.barButtonItem = self.addBarButtonItem
        presentationController.permittedArrowDirections = [.down, .up]
        self.present(chatNewItemViewController, animated: true)
        
        chatNewItemViewController.onNewGroup = {
            let storyboard = UIStoryboard(name: "Chat", bundle: Bundle.main)
            let navigationController = (storyboard.instantiateViewController(withIdentifier: "NavigationChatNewGroup") as? UINavigationController)!
            let chatNewGroupViewController = (navigationController.viewControllers.first! as? ChatNewGroupViewController)!
            chatNewGroupViewController.chatGroupViewModel.userLogged = self.chatCredentialViewModel.getUserLogged()
            
            self.present(navigationController, animated: true, completion: nil)
        }
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
        
        self.chatGroupViewModel.userLogged = self.chatCredentialViewModel.getUserLogged()
        loadRooms()
    }
    
    @objc func chatGroupHeaderDidSelect(gesture: UIGestureRecognizer) {
        //        let view:ChatGroupReusableView = (gesture.view as? ChatGroupReusableView)!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "messageSegue" {
            let chatMessageViewController = (segue.destination as? ChatMessageViewController)!
            
            let dic = (sender as? [String: Any])!
            let publicChunk = (dic["publicChunk"] as? PublicChunk)!
            let allChat = (dic["allChat"] as? Bool)!
            chatMessageViewController.chatMessageViewModel.userLogged = self.chatCredentialViewModel.getUserLogged()
            chatMessageViewController.chatMessageViewModel.room = publicChunk
            chatMessageViewController.isAllChat = allChat
        }
    }
    
    //
    // MARK: - Actions
}

extension ChatViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            
        } else if indexPath.section == 1 {
            let publicChunk = self.chatGroupViewModel.rooms[indexPath.row]
            self.performSegue(withIdentifier: "messageSegue", sender: ["publicChunk": publicChunk, "allChat": false])
        } else if indexPath.section == 2 {
            let publicChunk = self.chatClientViewModel.rooms[indexPath.row]
            self.performSegue(withIdentifier: "messageSegue", sender: ["publicChunk": publicChunk, "allChat": true])
        }
    }
}

extension ChatViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        } else if section == 1 {
            return self.chatGroupViewModel.rooms.count > 5 ? 5 : self.chatGroupViewModel.rooms.count
        } else if section == 2 {
            return self.chatClientViewModel.rooms.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ChatGroupCell = (collectionView.dequeueReusableCell(withReuseIdentifier: "ChatGroupCell", for: indexPath) as? ChatGroupCell)!
        
        if indexPath.section == 0 {
            
        } else if indexPath.section == 1 {
            cell.configure(withViewModel: self.chatGroupViewModel, indexPath: indexPath)
        } else if indexPath.section == 2 {
            let cell: ChatGroupExtendedCell = (collectionView.dequeueReusableCell(withReuseIdentifier: "ChatGroupExtendedCell", for: indexPath) as? ChatGroupExtendedCell)!
            cell.configure(withViewModel: self.chatClientViewModel, indexPath: indexPath)
            return cell
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeaderView = (collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ChatGroupReusableView", for: indexPath) as? ChatGroupReusableView)!
        sectionHeaderView.indexPath = indexPath
        
        if indexPath.section == 0 {
            sectionHeaderView.titleLabel.text = "Priority members".localized()
        } else if indexPath.section == 1 {
            sectionHeaderView.titleLabel.text = "Public groups".localized()
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.chatGroupHeaderDidSelect(gesture:)))
            sectionHeaderView.addGestureRecognizer(tap)
        } else if indexPath.section == 2 {
            sectionHeaderView.titleLabel.text = "All chats".localized()
        }
        
        return sectionHeaderView
    }
    
}

extension ChatViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        if indexPath.section == 0 {
            return CGSize(width: 72, height: 75)
        } else if indexPath.section == 1 {
            return CGSize(width: 72, height: 75)
        } else if indexPath.section == 2 {
            return CGSize(width: collectionView.bounds.width, height: 75)
        }
        
        return CGSize(width: 0, height: 0)
    }
    
}

extension ChatViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        // return UIModalPresentationStyle.FullScreen
        return UIModalPresentationStyle.none
    }
}
