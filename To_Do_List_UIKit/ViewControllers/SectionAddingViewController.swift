//
//  SectionAddingViewController.swift
//  To_Do_List_UIKit
//
//  Created by Dheeraj Pj on 21/01/24.
//

import Foundation
import UIKit

protocol SectionAddingViewControllerDelegate: AnyObject {
    func tappedOkButton()
    func tappedCancelButton()
}

class SectionAddingViewController: UIViewController {
    weak var delegate: SectionAddingViewControllerDelegate?
    
    @IBOutlet var textField: UITextField!
    
    @IBAction func addButtonAction(_ sender: Any) {
        print("In function: \(#function)")
        mainSections.append(Section(title: textField.text!, options: []))
        delegate?.tappedOkButton()
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        print("In function: \(#function)")
        delegate?.tappedCancelButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("In function: \(#function)")
//        textField.becomeFirstResponder()
    }
}
