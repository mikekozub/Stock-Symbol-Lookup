import UIKit
import Anchorage

class SearchViewController: UITableViewController, UISearchResultsUpdating {
    
    var stockSymbols = [Result]()
    let search = UISearchController(searchResultsController: nil)
    let tableSearch = UITableView()
    
    let cellReuseIdentifier = "cell"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Stock Symbol Lookup"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Register the table view cell class and its reuse id
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        // (optional) include this line if you want to remove the extra empty cell divider lines
//        self.tableView.tableFooterView = UIView()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type something here to search"
        navigationItem.searchController = search
        
        updateView()
    }
    
    func updateView() {
        if stockSymbols.count == 0 {
            self.tableView.isHidden = true
        } else {
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }
    
    func fetchSymbolsFromSearchBar(searchText: String) {
        if let possibleSymbols = APIManager().makeSymbolLookupCall(searchText: searchText) {
            deserializeSymbolData(loadedData: possibleSymbols)
        }
    }
    
    func deserializeSymbolData(loadedData: Data) {
        APIManager().deserializeSymbolData(loadedData: loadedData) { symbols in
            //only returning NYSE and NASDAQ exchanges for now
            self.stockSymbols = symbols.resultSet.result.filter { $0.exchDisp == "NYSE" || $0.exchDisp == "NASDAQ" }
            self.updateView()
        }
    }
    
}

extension SearchViewController { // Delegate methods
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }

        if text.count == 0 {
            stockSymbols.removeAll()
            updateView()
        }
        
        if text.count >= 3 {
            fetchSymbolsFromSearchBar(searchText: text)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchVC = StockViewController()
        searchVC.stockSymbol = stockSymbols[indexPath.item]
        let navController = UINavigationController(rootViewController: searchVC)
        navigationController?.present(navController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockSymbols.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: cellReuseIdentifier)
        let stockSymbol = "\(stockSymbols[indexPath.row].symbol)"
        let stockName = "\(stockSymbols[indexPath.row].name)"
        
        cell.textLabel?.text = stockSymbol
        cell.textLabel?.textColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        
        cell.detailTextLabel?.text = stockName
        cell.detailTextLabel?.textColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        cell.detailTextLabel?.adjustsFontSizeToFitWidth = true
        
        cell.selectionStyle = .none
        
        return cell
    }

}
