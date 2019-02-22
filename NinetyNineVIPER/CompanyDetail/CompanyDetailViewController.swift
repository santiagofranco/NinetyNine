//
//  CompanyDetailViewController.swift
//  NinetyNineVIPER
//
//  Created by Santi on 21/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import UIKit

/**
 This class manages interface logic and user inputs.
 
 We use a protocol for this class, because we are injecting this implementation in the presenter.
 We can change easily this implementation without break nothing.
 */

class CompanyDetailViewController: UIViewController {
    
    @IBOutlet weak var dataContainer: UIView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ricLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var descriptionTextview: UITextView!
    @IBOutlet weak var descriptionContainer: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var messageLabel: UILabel!
    
    var delegate: CompanyDetailViewDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Detail"
        setupShadow()
        
        delegate?.viewDidLoad()
    }
    
    fileprivate func setupShadow() {
        setShadow(to: shadowView)
        setShadow(to: descriptionContainer)
    }
    
    fileprivate func setShadow(to view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 10
    }

}

extension CompanyDetailViewController: CompanyDetailView {
    
    func showLoading() {
        activityIndicator.isHidden = false
        dataContainer.isHidden = true
        descriptionContainer.isHidden = true
    }
    
    func hideLoading() {
        activityIndicator.isHidden = true
        dataContainer.isHidden = false
        descriptionContainer.isHidden = false
    }
    
    func showCompany(_ company: Company) {
        priceLabel.text = "\(company.sharePrice)€"  //The currency could come from backend
        nameLabel.text = company.name
        ricLabel.text = company.ric
        countryLabel.text = company.country
        descriptionTextview.text = company.description
    }
    
    func showErrorLoadCompany() {
        messageLabel.text = "Something went wrong loading company"
        dataContainer.isHidden = true
        descriptionContainer.isHidden = true
        
    }
    
}
