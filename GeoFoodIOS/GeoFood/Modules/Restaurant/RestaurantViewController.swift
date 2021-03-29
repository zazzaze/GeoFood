//
//  RestaurantViewController.swift
//  GeoFood
//
//  Created by Егор on 17.03.2021.
//

import UIKit

class RestaurantViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        stocks.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellIdentifier, for: indexPath) as! StockCollectionViewCell
        cell.reloadFor(stock: stocks[indexPath.row])
        return cell
    }
    
    private var logo: UIImageView = UIImageView(image: UIImage(named: "empty"))
    private var nameLabel = UILabel()
    private var descriptionLabel = UITextView()
    
    private var stocksCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    private var token: String!
    
    private var stocks: [RestaurantStockModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.stocksCollection.reloadData()
            }
        }
    }
    private var restaurantsService = RestaurantService()
    private var currentRestaurant: RestaurantModel!
    
    private let collectionCellIdentifier = "stockCell"
    
    init(restaurant: RestaurantModel, token: String) {
        super.init(nibName: nil, bundle: nil)
        self.token = token
        self.currentRestaurant = restaurant
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        ImageLoader().loadImage(fileName: currentRestaurant.shopLogoFileName) { data in
            guard let data = data else {
                DispatchQueue.main.async {
                    self.logo.image = UIImage(named: "empty")
                }
                return
            }
            DispatchQueue.main.async {
                self.logo.image = UIImage(data: data)
            }
        }
        configureSubviews()
        addAllSubviews()
        initConstraints()
        RestaurantService().getRestaurantStocks(restaurantId: currentRestaurant.id, token: token) { rest in
            if let rest = rest {
                self.stocks = rest
            }
        }
    }
    
    func configureSubviews() {
        configureLogo()
        configureNameLabel()
        configureDescriptionLabel()
        configureStocksCollection()
    }
    
    func configureLogo() {
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.contentMode = .scaleAspectFill
    }
    
    func configureNameLabel() {
        nameLabel.textColor = .black
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = currentRestaurant.name
    }
    
    func configureDescriptionLabel() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = .gray
        descriptionLabel.text = currentRestaurant.description
    }
    
    func configureStocksCollection() {
        stocksCollection.register(StockCollectionViewCell.self, forCellWithReuseIdentifier: collectionCellIdentifier)
        stocksCollection.backgroundColor = .clear
        stocksCollection.translatesAutoresizingMaskIntoConstraints = false
        stocksCollection.dataSource = self
        stocksCollection.delegate = self
    }
    
    func addAllSubviews() {
        view.addSubview(logo)
        view.addSubview(nameLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(stocksCollection)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            logo.heightAnchor.constraint(equalToConstant: 80),
            logo.widthAnchor.constraint(equalToConstant: 80),
            logo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logo.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            
            nameLabel.topAnchor.constraint(equalTo: logo.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -10),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            descriptionLabel.bottomAnchor.constraint(greaterThanOrEqualTo: logo.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -10),
            
            stocksCollection.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 10),
            stocksCollection.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 10),
            stocksCollection.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -10),
            stocksCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5)
        ])
    }
    
    private func loadDataForCollection() {
        DispatchQueue.global(qos: .utility).async {
            self.restaurantsService.getRestaurantStocks(restaurantId: self.currentRestaurant.id, token: "") { stocks in
                guard let stocks = stocks else {
                    return
                }
                let group = DispatchGroup()
                for stock in stocks {
                    group.enter()
                    DispatchQueue.global(qos: .utility).async {
                        ImageLoader().loadImage(fileName: stock.stockImageFileName ?? "") { data in
                            guard let data = data else {
                                group.leave()
                                return
                            }
                            stock.image = UIImage(data: data)
                            group.leave()
                        }
                    }
                }
                group.wait()
                self.stocks = stocks
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 100, height: 60)
        }
}
