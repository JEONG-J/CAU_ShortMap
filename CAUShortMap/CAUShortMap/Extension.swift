//
//  Extension.swift
//  CAUShortMap
//
//  Created by 정의찬 on 12/10/23.
//

import Foundation
import UIKit

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredResults.count   
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchViewCell.identifier, for: indexPath) as? SearchViewCell else { return UITableViewCell() }
        cell.configure(model: CAUModel.buildingName[indexPath.row])
        
        let building = filteredResults[indexPath.row]
        cell.titleLabel.text = building.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBuildingName = filteredResults[indexPath.row]
        searchController.searchBar.text = selectedBuildingName.name
        
    
    }
}
