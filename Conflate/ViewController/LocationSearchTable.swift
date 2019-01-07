//
//  LocationSearchTable.swift
//  Conflate
//
//  Created by Mac on 1/5/19.
//  Copyright © 2019 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit
import MapKit

class LocationSearchTable:UITableViewController {
    var matchingItems:[MKMapItem] = []
    var mapView:MKMapView? = nil
}
extension LocationSearchTable : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print("updateSearchResults working")
       
    }
    
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        guard let mapView = mapView , let searchBarText = searchController.searchBar.text else { return }
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems
          //  DispatchQueue.main.async {
                self.tableView.reloadData()
            
        }
    }
}

extension LocationSearchTable {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifire.locationCell) else {
            fatalError(Constants.Strings.fattalError)
        }
        let selectedItem = matchingItems[indexPath.row].placemark
        cell.textLabel?.text = selectedItem.name
        cell.detailTextLabel?.text = ""
        return cell
    }
}
