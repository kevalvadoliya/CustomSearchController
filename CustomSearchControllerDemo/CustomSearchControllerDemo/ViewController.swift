//
//  ViewController.swift
//  CustomSearchControllerDemo
//
//  Created by Keval Vadoliya on 13/10/22.
//

import UIKit
import CustomSearchController

class ViewController: UIViewController {
    
    var filteredMovies: [Movie] = []

    @IBOutlet weak var cSearchController: CSearchController!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        filterMovies()
        // Do any additional setup after loading the view.
    }

    func setUI() {
        cSearchController.addAction = { sender in
            self.addAction()
        }
    }
    
    func addAction() {
        let alert = UIAlertController(title: "Movie", message: String(), preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Movie name"
        }
        alert.addTextField { textField in
            textField.placeholder = "Release year"
        }
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { _ in
            guard let movieName = alert.textFields?[0].text, let releaseYear = alert.textFields?[1].text, !movieName.isEmpty && !releaseYear.isEmpty  else {
                return
            }
            movies.append(Movie(name: movieName, releaseYear: releaseYear))
            self.filterMovies(self.cSearchController.cSearchBar.getSearchedText())
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        present(alert, animated: true)
    }
    
    func filterMovies(_ searchText: String = String()) {
        filteredMovies = movies.filter({
            if searchText.isEmpty {
                return true
            }
            return $0.name.lowercased().contains(
                searchText.lowercased()
            ) || $0.releaseYear.lowercased().contains(
                searchText.lowercased()
            )
        })
        tableView.reloadData()
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        cell.configureWithModel(filteredMovies[indexPath.row])
        return cell
    }
    
}

extension ViewController: SearchBarProtocol {
    
    func cancelButtonClicked(_ searchBar: UISearchBar) {
        filterMovies()
    }
    
    func textDidChange(_ searchBar: UISearchBar, searchText: String) {
        filterMovies(searchText)
    }
    
}

