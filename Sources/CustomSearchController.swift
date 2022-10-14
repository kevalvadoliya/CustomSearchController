//
//  CustomSearchController.swift
//  Helios
//
//  Created by kiprosh-xi on 03/10/19.
//  Copyright © 2019 Kiprosh. All rights reserved.
//

import UIKit

class CustomSearchController: UIView {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var addButton: RoundedButton!
    @IBOutlet weak var delegate: SearchBarProtocol?
    private var contentView: UIView!
    
    private var isSearched = false
    private var isSearchBarActive = false
    var addAction: ((Any) -> Void)?
    
    @IBOutlet private var searchBarWidthConstraint: NSLayoutConstraint!
    @IBOutlet private var addButtonWidthConstraint: NSLayoutConstraint!
    private var searchBarTextFieldLeftConstraint: NSLayoutConstraint?
    private var searchBarTextFieldRightConstraint: NSLayoutConstraint?
    private var searchBarTextFieldTopConstraint: NSLayoutConstraint?
    private var searchBarTextFieldBottomConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    private func xibSetup() {
        contentView = loadViewFromNib()
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth]
        addSubview(contentView)
        setUI()
        updateUIConstraints()
        updateSearchBarTextFieldConstraints()
        updateSubviewsProperties()
        setClearButtonAction()
    }
    
    private func setClearButtonAction() {
        guard let clearButton = searchTextField().value(forKey: "_clearButton") as? UIButton else {
            return
        }
        clearButton.addTarget(self, action: #selector(clearButtonAction(_:)), for: .touchUpInside)
    }
    
    private func updateUIConstraints() {
        updateAddButtonConstraint()
        updateSearchBarConstraint()
        updateSearchBarIconPosition()
        updatePlaceHolder()
        updateCancelButton()
    }
    
    private func updateAddButtonConstraint() {
        if !shouldShowButton || isSearchBarActive {
            addButtonWidthConstraint.constant = 0
            addButtonWidthConstraint.isActive = true
        } else {
            addButtonWidthConstraint.isActive = false
        }
    }
    
    private func updateSearchBarConstraint() {
        if !isSearchBarActive && shouldShowButton {
            searchBarWidthConstraint.constant = searchBar.isHidden ? 0 : 60
            searchBarWidthConstraint.isActive = true
        } else {
            searchBarWidthConstraint.isActive = false
        }
    }
    
    private func updateSearchBarIconPosition() {
        searchBar.setPositionAdjustment(UIOffset(horizontal: !isSearchBarActive && shouldShowButton ? 6 : 0, vertical: 0), for: .search)
    }
    
    private func setUI() {
        updatePlaceHolder()
        updateCancelButton()
        setAddButtonFontStyle()
    }
    
    private func updatePlaceHolder() {
        searchBar.placeholder = isSearchBarActive || !shouldShowButton ? "Search" : String()
    }
    
    private func updateCancelButton() {
        if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton {
            cancelButton.setTitle("Cancel", for: .normal)
        }
    }
    
    dynamic open var titleTextFont: UIFont = UIFont.preferredFont(forTextStyle: .subheadline) {
        didSet {
            setAddButtonFontStyle()
        }
    }
    
    private func setAddButtonFontStyle() {
        addButton.titleFont = titleTextFont
    }
    
    private func updateSearchBarTextFieldConstraints() {
        searchTextField().translatesAutoresizingMaskIntoConstraints = false
        searchBarTextFieldLeftConstraint = searchTextField().leftAnchor.constraint(equalTo: searchBar.leftAnchor, constant: 8)
        searchBarTextFieldLeftConstraint?.isActive = true
        searchBarTextFieldRightConstraint = searchTextField().rightAnchor.constraint(equalTo: searchBar.rightAnchor, constant: -8)
        searchBarTextFieldRightConstraint?.isActive = true
        searchBarTextFieldTopConstraint = searchTextField().topAnchor.constraint(equalTo: searchBar.topAnchor, constant: 6)
        searchBarTextFieldTopConstraint?.isActive = true
        searchBarTextFieldBottomConstraint = searchTextField().bottomAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: -6)
        searchBarTextFieldBottomConstraint?.isActive = true
    }
    
    private func enableCancelButton() {
        if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton {
            cancelButton.isEnabled = true
            cancelButton.setTitle("Cancel", for: .normal)
        }
    }
    
    @IBInspectable dynamic open var shouldShowButton: Bool = true {
        didSet {
            updateAddButtonAvailability()
        }
    }
    
    @IBInspectable dynamic open var isTextDidChangeActive: Bool = false
    
    private func updateAddButtonAvailability() {
        addButton.isHidden = !shouldShowButton
        updateUIConstraints()
    }
    
    @IBInspectable dynamic open var hideSearchBar: Bool = false {
        didSet {
            updateSearchBarAvailability()
        }
    }
    
    private func updateSearchBarAvailability() {
        searchBar.isHidden = hideSearchBar ? !isSearched : hideSearchBar
        updateUIConstraints()
    }
    
    @IBInspectable dynamic open var titleLabel: String = String() {
        didSet {
            updateTitleLabel()
        }
    }
    
    private func updateTitleLabel() {
        addButton.setTitle(titleLabel, for: .normal)
    }
    
    private func updateSubviewsProperties() {
        updateAddButtonAvailability()
        updateSearchBarAvailability()
        updateTitleLabel()
    }
    
    private func animate() {
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }
    
    func isContentHidden() -> Bool {
        return searchBar.isHidden && addButton.isHidden
    }
    
    func isSearchBarHidden() -> Bool {
        return searchBar.isHidden
    }
    
    func isAddButtonHidden() -> Bool {
        return addButton.isHidden
    }
    
    func getSearchedText() -> String {
        return searchBar.text ?? String()
    }
    
    private func searchTextField() -> UITextField {
        return searchBar.searchTextField
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        addAction?(sender)
    }
    
    @IBAction func clearButtonAction(_ sender: UIButton) {
        isSearched = false
        delegate?.cancelButtonClicked(searchBar)
    }
    
}

extension CustomSearchController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        isSearchBarActive = true
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearched = true
        updateUIConstraints()
        searchBar.endEditing(true)
        delegate?.searchButtonClicked(searchBar)
        enableCancelButton()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if isTextDidChangeActive {
            isSearched = true
            delegate?.textDidChange(searchBar, searchText: searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = String()
        searchBar.endEditing(true)
        searchBar.showsCancelButton = false
        isSearchBarActive = false
        updateUIConstraints()
        searchBarTextFieldRightConstraint?.isActive = false
        searchBarTextFieldRightConstraint = searchTextField().rightAnchor.constraint(equalTo: searchBar.rightAnchor, constant: -8)
        searchBarTextFieldRightConstraint?.isActive = true
        animate()
        if !isSearched {
            return
        }
        isSearched = false
        delegate?.cancelButtonClicked(searchBar)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        searchBarTextFieldRightConstraint?.isActive = false
        searchBarTextFieldRightConstraint = searchTextField().rightAnchor.constraint(equalTo: searchBar.rightAnchor, constant: -65)
        searchBarTextFieldRightConstraint?.isActive = true
        updateUIConstraints()
        animate()
    }
    
}
