//
//  StockCollectionViewCell.swift
//  GeoFood
//
//  Created by Егор on 25.03.2021.
//

import UIKit

class StockCollectionViewCell: UICollectionViewCell {
    
    private var stockImage = UIImageView()
    private var stockNameLabel = UILabel()
    private var descriptionLabel = UILabel()
    private var defaultPriceLabel = UILabel()
    private var currentPriceLabel = UILabel()
    
    init(stock: RestaurantStockModel) {
        super.init(frame: .zero)
        setUp()
    }
    
    private func setUp() {
        configureSubviews()
        addAllSubviews()
        initConstraints()
    }
    
    private func configureSubviews() {
        configureStockImage()
        configureStockNameLabel()
        configureDescriptionLabel()
        configureCurrentPriceLabel()
        configureDefaultPriceLabel()
    }
    
    private func configureStockImage() {
        stockImage.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureStockNameLabel() {
        stockNameLabel.textColor = .black
        stockNameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        stockNameLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureDescriptionLabel() {
        descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        descriptionLabel.textColor = .lightGray
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureCurrentPriceLabel() {
        currentPriceLabel.textColor = .black
        currentPriceLabel.font = UIFont.systemFont(ofSize: 13)
        currentPriceLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureDefaultPriceLabel() {
        defaultPriceLabel.textColor = .lightGray
        defaultPriceLabel.font = UIFont.systemFont(ofSize: 11)
        defaultPriceLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addAllSubviews() {
        addSubview(stockImage)
        addSubview(stockNameLabel)
        addSubview(descriptionLabel)
        addSubview(currentPriceLabel)
        addSubview(defaultPriceLabel)
    }
    
    private func initConstraints() {
        NSLayoutConstraint.activate([
            stockImage.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            stockImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            stockImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            stockNameLabel.topAnchor.constraint(equalTo: stockImage.bottomAnchor, constant: 5),
            stockNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            stockNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            descriptionLabel.topAnchor.constraint(equalTo: stockNameLabel.bottomAnchor, constant: 3),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            currentPriceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 7),
            currentPriceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            currentPriceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            defaultPriceLabel.topAnchor.constraint(equalTo: currentPriceLabel.bottomAnchor, constant: 3),
            defaultPriceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            defaultPriceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            defaultPriceLabel.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor, constant: -5) 
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
