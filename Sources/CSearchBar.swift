//
//  CSearchBar.swift
//  CustomSearchController
//
//  Created by Keval Vadoliya on 14/10/22.
//

import UIKit

public class CSearchBar: UISearchBar {
    
    internal var isSearched = false
    internal var isSearchBarActive = false
    var searchBarLeftConstraint: NSLayoutConstraint?
    var searchBarRightConstraint: NSLayoutConstraint?
    var searchBarTopConstraint: NSLayoutConstraint?
    var searchBarBottomConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateSearchBarTextFieldConstraints()
        updateCancelButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        updateSearchBarTextFieldConstraints()
        updateCancelButton()
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        updateSearchBarTextFieldConstraints()
        updateCancelButton()
    }
    
    private func updateCancelButton() {
        if let cancelButton = value(forKey: "cancelButton") as? UIButton {
            cancelButton.setTitle("Cancel", for: .normal)
        }
    }
    
    @IBInspectable dynamic open var isTextDidChangeActive: Bool = false
    
    private func updateSearchBarTextFieldConstraints() {
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchBarLeftConstraint = searchTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 8)
        searchBarLeftConstraint?.isActive = true
        searchBarRightConstraint = searchTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -8)
        searchBarRightConstraint?.isActive = true
        searchBarTopConstraint = searchTextField.topAnchor.constraint(equalTo: topAnchor, constant: 6)
        searchBarTopConstraint?.isActive = true
        searchBarBottomConstraint = searchTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6)
        searchBarBottomConstraint?.isActive = true
    }
    
    private func enableCancelButton() {
        if let cancelButton = value(forKey: "cancelButton") as? UIButton {
            cancelButton.isEnabled = true
            cancelButton.setTitle("Cancel", for: .normal)
        }
    }
    
    public func isSearchBarHidden() -> Bool {
        return isHidden
    }
    
    public func getSearchedText() -> String {
        return text ?? String()
    }
    
}
