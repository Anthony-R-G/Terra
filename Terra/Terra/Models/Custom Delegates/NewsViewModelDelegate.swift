//
//  NewsViewModelDelegate.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/8/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation

protocol NewsViewModelDelegate: class {
    //    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
    //    func onFetchFailed(with reason: String)
    func onFetchCompleted()
}