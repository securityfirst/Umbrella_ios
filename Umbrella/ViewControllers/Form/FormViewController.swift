//
//  FormViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 05/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

class FormViewController: UIViewController {

    @IBOutlet weak var formTableView: UITableView!
    
    //
    // MARK: - Properties
    lazy var formViewModel: FormViewModel = {
        let formViewModel = FormViewModel()
        return formViewModel
    }()
    
    //
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        NotificationCenter.default.addObserver(self, selector: #selector(FormViewController.loadForms(notification:)), name: Notification.Name("UmbrellaTent"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.formTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //
    // MARK: - Functions
    
    /// Receive the forms by notification
    ///
    /// - Parameter notification: notification with forms
    @objc func loadForms(notification: Notification) {
        let umbrella = notification.object as? Umbrella
        self.formViewModel.umbrella = umbrella!
        
        if let tableView = self.formTableView {
            tableView.reloadData()
        }
    }
    
    //
    // MARK: - UIStoryboardSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fillFormSegue" {
            let fillFormViewController = (segue.destination as? FillFormViewController)!
            if let form = sender as? Form {
                fillFormViewController.form = form
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension FormViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.formViewModel.umbrella.forms.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FormCell = (tableView.dequeueReusableCell(withIdentifier: "FormCell", for: indexPath) as? FormCell)!
        cell.configure(withViewModel: formViewModel, indexPath: indexPath)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension FormViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 40))
        view.backgroundColor = UIColor.white
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.width - 30, height: 40))
        label.font = UIFont.init(name: "SFProText-SemiBold", size: 12)
        label.textColor = #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5764705882, alpha: 1)
        label.text = "Available forms"
        view.addSubview(label)
        return view
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let form = self.formViewModel.umbrella.forms[indexPath.row]
        self.performSegue(withIdentifier: "fillFormSegue", sender: form)
    }
}
