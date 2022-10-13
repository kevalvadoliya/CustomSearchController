//
//  SearchBarProtocol.swift
//  Helios
//
//  Created by kiprosh-xi on 25/09/19.
//  Copyright © 2019 Kiprosh. All rights reserved.
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
