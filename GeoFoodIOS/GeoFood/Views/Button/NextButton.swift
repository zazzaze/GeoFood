//
//  NextButton.swift
//  GeoFood
//
//  Created by Егор on 21.04.2021.
//

import UIKit

@IBDesignable
class NextButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageEdgeInsets.left = self.bounds.width - self.imageView!.bounds.width - 10;
        titleEdgeInsets.right = self.imageView!.bounds.width + 15
        titleEdgeInsets.left = 1
    }
    
    private func setUp() {
        setTitleColor(UIColor(named: "dark_blue"), for: .normal)
        backgroundColor = UIColor(named: "light_green")
        imageView?.tintColor = UIColor(named: "dark_blue")
        self.layer.cornerRadius = 10
        setImage(UIImage(named: "right_arrow"), for: .normal)
    }
}
