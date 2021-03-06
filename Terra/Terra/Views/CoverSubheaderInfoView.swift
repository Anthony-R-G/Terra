//
//  SubheaderInfoView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/18/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

final class CoverSubheaderInfoView: UIView {
    //MARK: -- UI Element Initialization
    
    private lazy var numbersTitleLabel: UILabel = {
        return Factory.makeLabel(title: "Population",
                                 fontWeight: .light,
                                 fontSize: 16,
                                 widthAdjustsFontSize: true,
                                 color: .white,
                                 alignment: .left)
    }()
    
    private lazy var numbersDataLabel: UILabel = {
        return Factory.makeLabel(title: species.population.numbers,
                                 fontWeight: .medium,
                                 fontSize: 18,
                                 widthAdjustsFontSize: true,
                                 color: .white,
                                 alignment: .left)
    }()
    
    private lazy var trendTitleLabel: UILabel = {
        return Factory.makeLabel(title: "Trend",
                                 fontWeight: .light,
                                 fontSize: 16,
                                 widthAdjustsFontSize: true,
                                 color: .white,
                                 alignment: .left)
    }()
    
    private lazy var trendDataLabel: UILabel = {
        return Factory.makeLabel(title: species.population.trend.rawValue,
                                 fontWeight: .medium,
                                 fontSize: 18,
                                 widthAdjustsFontSize: true,
                                 color: species.population.trend == .decreasing ? #colorLiteral(red: 1, green: 0.4507741928, blue: 0.5112823844, alpha: 1) : #colorLiteral(red: 0.7970843911, green: 1, blue: 0.5273691416, alpha: 1),
                                 alignment: .left)
    }()
    
    private lazy var lastAssessedTitleLabel: UILabel = {
        return Factory.makeLabel(title: "Last Assessed",
                                 fontWeight: .light,
                                 fontSize: 16,
                                 widthAdjustsFontSize: true,
                                 color: .white,
                                 alignment: .left)
    }()
    
    private lazy var lastAssessedDataLabel: UILabel = {
        return Factory.makeLabel(title: "\(species.population.assessmentDate)",
                                 fontWeight: .medium,
                                 fontSize: 18,
                                 widthAdjustsFontSize: true,
                                 color: .white,
                                 alignment: .left)
    }()
    
    private lazy var numbersStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            numbersTitleLabel, numbersDataLabel
        ])
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var trendStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            trendTitleLabel, trendDataLabel
        ])
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var lastAssessedStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            lastAssessedTitleLabel, lastAssessedDataLabel
        ])
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var horizontalStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
        numbersStack, trendStack, lastAssessedStack
        ])
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    //MARK: -- Properties
    
    private var species: Species!
    
    //MARK: -- Methods
    required init(species: Species) {
        self.species = species
        super.init(frame: .zero)
        addSubview(horizontalStack)
        setHorizontalStackConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate extension CoverSubheaderInfoView {
    
    func setHorizontalStackConstraints() {
        horizontalStack.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.75)
        }
    }
}
