import UIKit
import Anchorage

class StockViewController: UIViewController {
    var stockSymbol: Result?
    
    let symbolLabel = UILabel()
    let nameLabel = UILabel()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        addNavigationBar()
        addViews()
        super.viewDidLoad()
    }
    
    func addNavigationBar() {
        if let navigationController = navigationController {
            //makes navBar white/clear
            navigationController.navigationBar.setBackgroundImage(UIImage(), for:.default)
            navigationController.navigationBar.shadowImage = UIImage()
            navigationController.navigationBar.layoutIfNeeded()
            
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                               target: self,
                                                               action: #selector(backButtonTapped))
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    func addViews() {
        guard let stockSymbol = stockSymbol else { return }
        
        view.addSubview(symbolLabel)
        symbolLabel.text = stockSymbol.symbol
        symbolLabel.topAnchor == view.safeAreaLayoutGuide.topAnchor + 50
        symbolLabel.widthAnchor == view.safeAreaLayoutGuide.widthAnchor - 25
        symbolLabel.heightAnchor == 50
        symbolLabel.centerXAnchor == view.safeAreaLayoutGuide.centerXAnchor
        symbolLabel.textAlignment = .center
        
        view.addSubview(nameLabel)
        nameLabel.text = stockSymbol.name
        nameLabel.topAnchor == symbolLabel.bottomAnchor + 25
        nameLabel.widthAnchor == view.safeAreaLayoutGuide.widthAnchor - 25
        nameLabel.heightAnchor == 50
        nameLabel.centerXAnchor == view.safeAreaLayoutGuide.centerXAnchor
        nameLabel.textAlignment = .center
    }
    
    @objc func backButtonTapped(sender: UIButton) {
        dismiss(animated: true)
    }
    
}
