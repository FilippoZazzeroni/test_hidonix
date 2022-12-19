//
//  SearchResultsViewController.swift
//  test_hidonix
//
//  Created by Filippo Zazzeroni on 19/12/22.
//

import UIKit

class SearchResultsViewController: UIViewController {
    
    //MARK: Properties
    
    private let tableView = UITableView()
    
    var onPressedResultCell: ((Int)-> Void)!
    
    var locations: [Location]!
    
    private var filteredLocations = [Location]()
    
    //! MARK: Methods
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SearchResultCell")
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.backgroundColor = .cyan
    }
    
}

extension SearchResultsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredLocations.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell")
        cell?.textLabel?.text = filteredLocations[indexPath.row].name
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = filteredLocations[indexPath.row]
        let indexToReturn = locations.firstIndex(where: { $0.name == location.name })
        onPressedResultCell(indexToReturn!)
    }
    
}

extension SearchResultsViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filteredLocations = locations.filter({ location in
                return location.name.contains(searchText)
            })
            tableView.reloadData()
        }
    }
}
