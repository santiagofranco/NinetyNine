//
//  CompanyTableViewCell.swift
//  NinetyNineVIPER
//
//  Created by Santi on 21/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import UIKit

class CompanyTableViewCell: UITableViewCell {

    static let identifier = "CompanyTableViewCell"
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ricLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        setupShadow()
    }
    
    fileprivate func setupShadow() {
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowOffset = .zero
        shadowView.layer.shadowRadius = 10
    }
    
    func bind(company: Company) {
        colorView.backgroundColor = .purple
        nameLabel.text = company.name
        ricLabel.text = company.ric
        priceLabel.text = "\(company.sharePrice)"
        currencyLabel.text = "€" //This could come from backend
    }

    
}
