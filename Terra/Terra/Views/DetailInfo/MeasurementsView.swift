//
//  MeasurementsView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/21/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

final class MeasurementsView: UIView {
    
    //MARK: -- UI Element Initialization
    
    private lazy var heightTitleLabel: UILabel = {
        return Factory.makeLabel(title: "Height",
                                 fontWeight: .bold,
                                 fontSize: 19,
                                 widthAdjustsFontSize: true,
                                 color: .white,
                                 alignment: .left)
    }()
    
    private lazy var maleHeightDataLabel: UILabel = {
        return Factory.makeLabel(title: "Male: \(viewModel.speciesMaleHeight)",
            fontWeight: .regular,
            fontSize: 17,
            widthAdjustsFontSize: true,
            color: .white,
            alignment: .left)
    }()
    
    private lazy var femaleHeightDataLabel: UILabel = {
        return Factory.makeLabel(title: "Female: \(viewModel.speciesFemaleHeight)",
            fontWeight: .regular,
            fontSize: 17,
            widthAdjustsFontSize: true,
            color: .white,
            alignment: .left)
    }()
    
    private lazy var heightReferenceTitleLabel: UILabel = {
        var measurementType = String()
        if viewModel.speciesCommonName == "Blue Whale" || viewModel.speciesCommonName  == "Great White Shark" {
            measurementType = "Body length"
        } else {
            measurementType = "Adult, At Shoulder"
        }
        return Factory.makeLabel(title: measurementType,
                                 fontWeight: .regular,
                                 fontSize: 15,
                                 widthAdjustsFontSize: true,
                                 color: .lightGray,
                                 alignment: .left)
    }()
    
    private lazy var heightStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            heightTitleLabel, maleHeightDataLabel, femaleHeightDataLabel, heightReferenceTitleLabel
        ])
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.spacing = Constants.padding
        sv.setCustomSpacing(Constants.padding/2, after: femaleHeightDataLabel)
        return sv
    }()
    
    private lazy var weightTitleLabel: UILabel = {
        return Factory.makeLabel(title: "Weight",
                                 fontWeight: .bold,
                                 fontSize: 19,
                                 widthAdjustsFontSize: true,
                                 color: .white,
                                 alignment: .right)
    }()
    
    private lazy var maleWeightDataLabel: UILabel = {
        return Factory.makeLabel(title: viewModel.speciesMaleWeight,
            fontWeight: .regular,
            fontSize: 17,
            widthAdjustsFontSize: true,
            color: .white,
            alignment: .right)
    }()
    
    private lazy var femaleWeightDataLabel: UILabel = {
        return Factory.makeLabel(title: viewModel.speciesFemaleWeight,
            fontWeight: .regular,
            fontSize: 17,
            widthAdjustsFontSize: true,
            color: .white,
            alignment: .right)
    }()
    
    private lazy var weightStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            weightTitleLabel, maleWeightDataLabel, femaleWeightDataLabel, UILabel()
        ])
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.spacing = Constants.padding
        return sv
    }()
    
    private lazy var horizontalStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            heightStackView, weightStackView
        ])
        sv.spacing = Constants.padding/2
        sv.alignment = .leading
        return sv
    }()
    
    //MARK: -- Properties
    
    private var viewModel: SpeciesDetailViewModel
    
    //MARK: -- Methods
    
    required init(viewModel: SpeciesDetailViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        heightAnchor.constraint(equalToConstant: 140.deviceScaled).isActive = true
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: -- Add Subviews & Constraints

fileprivate extension MeasurementsView {
    func addSubviews() {
        addSubview(horizontalStack)
    }
    
    func setConstraints() {
        setStackConstraints()
    }
    
    func setStackConstraints() {
        horizontalStack.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
