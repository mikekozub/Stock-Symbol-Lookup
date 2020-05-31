import UIKit

class APIManager {
    
    let apiKey = "VLgSTkr9r_fLqUESihNY"
    
    func makeSymbolLookupCall(searchText: String) -> Data? {
        let yahooUrl = "http://d.yimg.com/autoc.finance.yahoo.com/autoc?query=" + searchText + "&region=1&lang=en"
        print(yahooUrl)
        do {
            let url = URL(string: yahooUrl)!
            let data = try Data(contentsOf: url)
            return data
        } catch {
            print(error)
        }
        return nil
    }
    
    func deserializeSymbolData(loadedData: Data, onCompletion: @escaping (_ stockSymbols: StockSymbolApiResponse) -> Void){
        DispatchQueue.global().async {
            do {
                let decoder = JSONDecoder()
                let symbolDataDecoded = try decoder.decode(StockSymbolApiResponse.self, from: loadedData)
                DispatchQueue.main.async {
                    onCompletion(symbolDataDecoded)
                }
            } catch {
                print(error)
            }
        }
    }

}
