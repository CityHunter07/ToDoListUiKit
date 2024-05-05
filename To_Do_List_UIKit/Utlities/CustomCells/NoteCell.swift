//
//  CustomTableViewCells.swift
//  To_Do_List_UIKit
//
//  Created by Dheeraj Pj on 22/01/24.
//

import Foundation
import UIKit

class NoteCell: UITableViewCell {
    // initializing all required variables
    weak var labelHeightConstraint: NSLayoutConstraint!
    var contentLabel: UILabel = {
        let Label = UILabel(frame: CGRect(x: 50, y: 5, width: 50, height: 30))
//        let Label = UILabel()
        Label.font = UIFont(name: "Helvetica-Bold", size: 18)
        Label.textColor = .black
        Label.isHidden = false
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.numberOfLines = 0
        return Label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(contentLabel)
        
        NSLayoutConstraint.activate([
            contentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            contentLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
//        labelHeightConstraint.constant = contentLabel.sizeThatFits(CGSize(width: contentLabel.bounds.width, height: CGFloat.greatestFiniteMagnitude)).height
    }
    
    // adding corner radius to top and bottom row in section
    override func layoutSubviews() {
        super.layoutSubviews()
        // Get the index path of the cell
        guard let indexPath = (superview as? UITableView)?.indexPath(for: self) else {
            return
        }
        
        
        let cornerRadius: CGFloat = 10
        let numberOfRowsInSection = (superview as? UITableView)?.numberOfRows(inSection: indexPath.section) ?? 0
        
        // Apply corner radius based on the cell position in the section
        if numberOfRowsInSection == 1 {
            layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        } 
        else if indexPath.row == 0 {
            layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//            layer.
        }
        else if indexPath.row == numberOfRowsInSection - 1 {
            layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } 
        else {
            layer.maskedCorners = []
        }
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented for App tableView cell")
    }
}


