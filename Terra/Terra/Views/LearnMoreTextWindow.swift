//
//  OverviewSummaryView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/12/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

class LearnMoreTextWindow: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = Factory.makeLabel(title: strategy.titleLabel(),
                                      weight: .bold,
                                      size: 24,
                                      color: Constants.titleLabelColor,
                                      alignment: .left)
        return label
    }()
    
    private lazy var bodyLabel: UILabel = {
        let label = Factory.makeLabel(title: strategy.bodyText(),
                                      weight: .regular,
                                      size: 16,
                                      color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8983304795),
                                      alignment: .natural)
        
        label.numberOfLines = 0
        return label
    }()
    
    var strategy: LearnMoreTextWindowStrategy!
    
    private func setBottomAnchor() {
        if let lastSubview = subviews.last {
            bottomAnchor.constraint(equalTo: lastSubview.bottomAnchor, constant: 20).isActive = true
        }
    }
    
    init(strategy: LearnMoreTextWindowStrategy) {
        super.init(frame: .zero)
        self.strategy = strategy
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2452108305)
        layer.cornerRadius = 20
        addSubviews()
        setConstraints()
        setBottomAnchor()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate extension LearnMoreTextWindow {
    func addSubviews() {
        let UIElements = [titleLabel, bodyLabel]
        UIElements.forEach { addSubview($0) }
        UIElements.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    func setConstraints() {
        setTitleLabelConstraints()
        setLabelConstraints()
        
    }
    
    func setTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    func setLabelConstraints() {
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            bodyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            bodyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
}