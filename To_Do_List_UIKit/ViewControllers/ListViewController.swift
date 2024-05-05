//
//  ListViewController.swift
//  To_Do_List_UIKit
//
//  Created by Dheeraj Pj on 19/01/24.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    
    let sections: [String] = ["Primary", "Secondary", "Projects"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("In function: \(#function)")
        initializeData()
        addButtonInZStack()
    }
    
    private func initializeData() {
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "customCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func addButtonInZStack() {
        let plusButton = PlusButton()
        view.addSubview(plusButton)
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            plusButton.widthAnchor.constraint(equalToConstant: 200),
            plusButton.heightAnchor.constraint(equalToConstant: 200),
            plusButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            plusButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
        plusButton.delegate = self
    }
}

// MARK: - PlusButtonDelegate, SectionAddingViewControllerDelegate extension
extension ListViewController: PlusButtonDelegate, SectionAddingViewControllerDelegate {
    func tappedOkButton() {
        print("Reloading data in tableView")
        dismiss(animated: true)
        tableView.reloadData()
    }
    
    func tappedCancelButton() {
        dismiss(animated: true)
    }
    
    func newSectionButtonIsTapped(_ sender: UIButton) {
        print("In function: \(#function)")
        var alert: String?
        if sender.tag == 1 {
            let sectionViewController = UIStoryboard.SectionAddingVC
            sectionViewController.delegate = self
            sectionViewController.modalPresentationStyle = .formSheet
            present(sectionViewController, animated: true) {
                sectionViewController.textField.becomeFirstResponder()
            }
        }
        else {
            alert = "clicked add new alert"
            
            let alertController = UIAlertController(title: alert!, message: "", preferredStyle: .actionSheet)
            
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(action)
            
            present(alertController, animated: true, completion: nil)
        }
    }
}

// MARK: - TableViewDelegate extension
extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("In function: \(#function)")
        let currentSection = mainSections[section]
        if currentSection.isOpened {
            return currentSection.options.count + 1
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("In function: \(#function)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        if indexPath.row == 0 {
            cell.self.customLabel.text = mainSections[indexPath.section].title
            cell.self.customLabel.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        }
        else {
            cell.self.customLabel.text = mainSections[indexPath.section].options[indexPath.row - 1]
            cell.self.customLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {           // to tell the table view controller the number of sections in the view
        print("In function: \(#function)")
        return mainSections.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("In function: \(#function)")
        tableView.deselectRow(at: indexPath, animated: true)
        mainSections[indexPath.section].isOpened = !mainSections[indexPath.section].isOpened // if is opened == true then turn to false and vice versa
        tableView.reloadSections([indexPath.section], with: .none) // here we are sending [indexPath.section] as a section to consider a row as section
        
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { // to give a title to the header of section
//        print("In function: \(#function)")
//        return mainSections[section].title
//    }
}

class CustomTableViewCell: UITableViewCell {
//    static let cellId = "customCell"
    
    var customLabel: UILabel = {
        let Label = UILabel(frame: CGRect(x: 50, y: 5, width: 200, height: 30))
//        Label.backgroundColor = .magenta
        Label.font = UIFont(name: "Helvetica-Bold", size: 18)
        Label.textColor = .black
        Label.isHidden = false
        Label.translatesAutoresizingMaskIntoConstraints = false
//        Label.text = self.textLabel?.text
        return Label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let padding: CGFloat = 10
        contentView.addSubview(customLabel)
        NSLayoutConstraint.activate([
            customLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            customLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            customLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: padding),
            customLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
        ])
        
//        self.accessibilityIdentifier = "customCell"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
