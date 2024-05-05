//
//  UIStoryBoard + Extension.swift
//  To_Do_List_UIKit
//
//  Created by Dheeraj Pj on 19/01/24.
//

import Foundation
import UIKit

extension UIStoryboard {
    static var listVC: ListViewController {
        get {
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListVC") as! ListViewController
        }
    }
    
    static var SectionAddingVC: SectionAddingViewController {
        get {
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SectionAddingVC") as! SectionAddingViewController
        }
    }
    
}
