//
//  RestaurantViewController.swift
//  GeoFood
//
//  Created by Егор on 17.03.2021.
//

import UIKit

class RestaurantViewController: UIViewController {
    
    private var currentRestaurant: RestaurantModel!
    private var logo: UIImageView = UIImageView()
    private var nameLabel = UILabel()
    private var descriptionLabel = UITextView()
    
    private var stocksCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    private let collectionCellIdentifier = "stockCell"
    
    convenience init(restaurant: RestaurantModel) {
        self.init()
        self.currentRestaurant = restaurant
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        configureSubviews()
        addAllSubviews()
        initConstraints()
        logo.image = currentRestaurant.logo ?? UIImage(named: "empty")
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
    }
    
    func configureDescriptionLabel() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = .gray
    }
    
    func configureStocksCollection() {
        stocksCollection.register(StockCollectionViewCell.self, forCellWithReuseIdentifier: collectionCellIdentifier)
        stocksCollection.backgroundColor = .clear
        stocksCollection.translatesAutoresizingMaskIntoConstraints = false
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
            nameLabel.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -10),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            descriptionLabel.bottomAnchor.constraint(greaterThanOrEqualTo: logo.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -10),
            
            stocksCollection.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 10),
            stocksCollection.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 10),
            stocksCollection.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -10),
            stocksCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5)
        ])
    }
}
