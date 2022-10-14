//
//  SearchBarProtocol.swift
//  CustomSearchController
//
//  Created by Keval Vadoliya on 14/10/22.
//

import UIKit

@objc protocol SearchBarProtocol: AnyObject {

    @objc optional func searchButtonClicked(_ searchBar: UISearchBar)

    @objc optional func cancelButtonClicked(_ searchBar: UISearchBar)
    
    @objc optional func textDidChange(_ searchBar: UISearchBar, searchText: String)

}

extension SearchBarProtocol {
    
    func searchButtonClicked(_ searchBar: UISearchBar) { }
    
    func cancelButtonClicked(_ searchBar: UISearchBar) { }
    
    func textDidChange(_ searchBar: UISearchBar, searchText: String) { }
    
}
