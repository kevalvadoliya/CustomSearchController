//
//  TableViewCell.swift
//  CustomSearchControllerDemo
//
//  Created by Keval Vadoliya on 21/10/22.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var releaseYear: UILabel!
    
    func configureWithModel(_ movie: Movie) {
        movieName.text = movie.name
        releaseYear.text = "Release Year: " + movie.releaseYear
    }

}
