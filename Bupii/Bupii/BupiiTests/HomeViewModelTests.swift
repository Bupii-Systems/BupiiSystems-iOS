//
//  HomeViewModelTests.swift
//  BupiiTests
//
//  Created by Pedro Ribeiro on 27/06/2025.
//

import XCTest
@testable import Bupii

final class HomeViewModelTests: XCTestCase {

    func testEstablishmentNameDefaultsCorrectly() {
        let viewModel = HomeViewModel()
        XCTAssertEqual(viewModel.establishmentName, "BarbeariaRockeFeller")
    }

    func testUserNameWhenNoNameProvided() {
        let viewModel = HomeViewModel(displayName: nil)
        XCTAssertEqual(viewModel.userName, "Visitante")
    }

    func testUserNameWhenNameProvided() {
        let viewModel = HomeViewModel(displayName: "Henrique")
        XCTAssertEqual(viewModel.userName, "Henrique")
    }
}
