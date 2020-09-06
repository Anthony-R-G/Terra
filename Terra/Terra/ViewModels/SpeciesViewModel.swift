//
//  SpeciesViewModel.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/9/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation

final class SpeciesViewModel {
    //MARK: -- Properties
    
    private weak var delegate: SpeciesViewModelDelegate?
    
    private var animalData: [Species] = []
    
    private var redListCategoryFilteredSpecies: [Species] = [] {
        didSet {
            delegate?.fetchCompleted()
        }
    }
    
    var searchFilteredSpecies: [Species] {
        get {
            guard let searchString = searchString, !searchString.isEmpty else { return redListCategoryFilteredSpecies }
            return Species.getFilteredSpeciesByName(arr: redListCategoryFilteredSpecies, searchString: searchString)
        }
    }
    
    private var searchString: String? = nil {
        didSet {
            delegate?.fetchCompleted()
        }
    }
    
    var species: [Species] {
        return animalData
    }
    
    
    //MARK: -- Methods
    
    //Public Accessors
   
    func updateRedListCategoryFilteredAnimals(from selectedTabTag: Int) {
        Utilities.sendHapticFeedback(action: .selectionChanged)
        switch selectedTabTag {
        case 0:
            redListCategoryFilteredSpecies = animalData
            
        case 1:
            redListCategoryFilteredSpecies = Species.getFilteredSpeciesByConservationStatus(arr: animalData, by: .critical)
            
        case 2:
            redListCategoryFilteredSpecies = Species.getFilteredSpeciesByConservationStatus(arr: animalData, by: .endangered)
            
        case 3:
            redListCategoryFilteredSpecies =  Species.getFilteredSpeciesByConservationStatus(arr: animalData, by: .vulnerable)
            
        default: ()
        }
    }
    
    func updateSearchString(newString: String) {
        searchString = newString
    }
    
    init(delegate: SpeciesViewModelDelegate) {
        self.delegate = delegate
    }
}

extension SpeciesViewModel {
    func fetchSpeciesData() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            FirestoreService.manager.getAllSpeciesData() { (result) in
                switch result {
                case .success(let speciesData):
                    self.animalData = speciesData
                    self.redListCategoryFilteredSpecies = speciesData
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
