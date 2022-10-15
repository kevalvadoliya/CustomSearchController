//
//  CSearchController.swift
//  CustomSearchController
//
//  Created by Keval Vadoliya on 14/10/22.
//

import UIKit

class CSearchController: UIView {

    @IBOutlet weak var cSearchBar: CSearchBar!
    @IBOutlet weak var cButton: CButton!
    @IBOutlet weak var delegate: SearchBarProtocol?
    private var contentView: UIView!
    var addAction: ((Any) -> Void)?
    
    @IBOutlet private var searchBarWidthConstraint: NSLayoutConstraint!
    @IBOutlet private var addButtonWidthConstraint: NSLayoutConstraint!
    
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
        updateSubviewsProperties()
        setClearButtonAction()
    }
    
    private func updateUIConstraints() {
        updateAddButtonConstraint()
        updateSearchBarConstraint()
        updateSearchBarIconPosition()
        updatePlaceHolder()
    }
    
    private func updateAddButtonConstraint() {
        if !shouldShowButton || cSearchBar.isSearchBarActive {
            addButtonWidthConstraint.constant = 0
            addButtonWidthConstraint.isActive = true
        } else {
            addButtonWidthConstraint.isActive = false
        }
    }
    
    private func updateSearchBarConstraint() {
        if !cSearchBar.isSearchBarActive && shouldShowButton {
            searchBarWidthConstraint.constant = cSearchBar.isHidden ? 0 : 60
            searchBarWidthConstraint.isActive = true
        } else {
            searchBarWidthConstraint.isActive = false
        }
    }
    
    private func updateSearchBarIconPosition() {
        cSearchBar.setPositionAdjustment(
            UIOffset(
                horizontal: !cSearchBar.isSearchBarActive && shouldShowButton ? 6 : 0,
                vertical: 0
            ),
            for: .search
        )
    }
    
    private func setUI() {
        updatePlaceHolder()
    }
    
    private func updatePlaceHolder() {
        cSearchBar.placeholder = cSearchBar.isSearchBarActive || !shouldShowButton ? "Search" : String()
    }
    
    private func enableCancelButton() {
        if let cancelButton = cSearchBar.value(forKey: "cancelButton") as? UIButton {
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
        cButton.isHidden = !shouldShowButton
        updateUIConstraints()
    }
    
    @IBInspectable dynamic open var hideSearchBar: Bool = false {
        didSet {
            updateSearchBarAvailability()
        }
    }
    
    private func updateSearchBarAvailability() {
        cSearchBar.isHidden = hideSearchBar ? !cSearchBar.isSearched : hideSearchBar
        updateUIConstraints()
    }
    
    @IBInspectable dynamic open var titleLabel: String = String() {
        didSet {
            updateTitleLabel()
        }
    }
    
    private func updateTitleLabel() {
        cButton.setTitle(titleLabel, for: .normal)
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
        return cSearchBar.isHidden && cButton.isHidden
    }
    
    func isAddButtonHidden() -> Bool {
        return cButton.isHidden
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        addAction?(sender)
    }
    
    private func setClearButtonAction() {
        guard let clearButton = cSearchBar.searchTextField.value(forKey: "_clearButton") as? UIButton else {
            return
        }
        clearButton.addTarget(self, action: #selector(clearButtonAction(_:)), for: .touchUpInside)
    }
    
    @IBAction func clearButtonAction(_ sender: UIButton) {
        cSearchBar.isSearched = false
        delegate?.cancelButtonClicked(cSearchBar)
    }
    
}

extension CSearchController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        cSearchBar.isSearchBarActive = true
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        cSearchBar.isSearched = true
        updateUIConstraints()
        searchBar.endEditing(true)
        delegate?.searchButtonClicked(searchBar)
        enableCancelButton()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if isTextDidChangeActive {
            cSearchBar.isSearched = true
            delegate?.textDidChange(searchBar, searchText: searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        cSearchBar.text = String()
        cSearchBar.endEditing(true)
        cSearchBar.showsCancelButton = false
        cSearchBar.isSearchBarActive = false
        updateUIConstraints()
        cSearchBar.searchBarRightConstraint?.isActive = false
        cSearchBar.searchBarRightConstraint = cSearchBar.searchTextField.rightAnchor.constraint(equalTo: cSearchBar.rightAnchor, constant: -8)
        cSearchBar.searchBarRightConstraint?.isActive = true
        animate()
        if !cSearchBar.isSearched {
            return
        }
        cSearchBar.isSearched = false
        delegate?.cancelButtonClicked(cSearchBar)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        cSearchBar.searchBarRightConstraint?.isActive = false
        cSearchBar.searchBarRightConstraint = searchBar.searchTextField.rightAnchor.constraint(equalTo: searchBar.rightAnchor, constant: -65)
        cSearchBar.searchBarRightConstraint?.isActive = true
        updateUIConstraints()
        animate()
    }
    
}
