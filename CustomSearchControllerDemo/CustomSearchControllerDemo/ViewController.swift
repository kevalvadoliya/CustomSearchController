//
//  ViewController.swift
//  CustomSearchControllerDemo
//
//  Created by Keval Vadoliya on 13/10/22.
//

import UIKit
import CustomSearchController

class ViewController: UIViewController {
    
    var movies: [String] = ["Batman", "Spiderman", "Superman"]
    var filteredMovies: [String] = []

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
            textField.placeholder = "Enter the movie name"
        }
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { _ in
            guard let movie = alert.textFields?.first?.text, !movie.isEmpty else {
                return
            }
            self.movies.append(movie)
            self.filterMovies(self.cSearchController.cSearchBar.getSearchedText())
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        present(alert, animated: true)
    }
    
    func filterMovies(_ searchText: String = String()) {
        filteredMovies = movies.filter({ searchText.isEmpty ? true : $0.lowercased().contains(searchText.lowercased()) })
        tableView.reloadData()
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = filteredMovies[indexPath.row]
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

