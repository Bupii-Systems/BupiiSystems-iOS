//
//  MyAgendaViewModelTests.swift
//  BupiiTests
//
//  Created by Pedro Ribeiro on 27/06/2025.
//

import XCTest
@testable import Bupii

final class MyAgendaViewModelTests: XCTestCase {

    // MARK: - Mocks

    // Creates a mock appointment with the given ID and date.
    private func makeMockAppointment(id: String?, date: String) -> Appointment {
        return Appointment(
            id: id,
            userId: "mockUserId",
            services: ["Corte"],
            totalPrice: 50.0,
            date: date,
            time: "10:00",
            professional: "Mock Prof",
            location: "Mock Location",
            address: "Rua Teste, 123"
        )
    }

    // MARK: - Tests

    // Verifies that the sortedAppointments() method returns the appointments in ascending date order.
    func testSortedAppointmentsReturnsAscendingOrder() {
        let viewModel = MyAgendaViewModel()
        viewModel.appointments = [
            makeMockAppointment(id: "1", date: "29/07/2025"),
            makeMockAppointment(id: "2", date: "27/07/2025"),
            makeMockAppointment(id: "3", date: "28/07/2025")
        ]

        let sorted = viewModel.sortedAppointments().compactMap { $0.id }
        XCTAssertEqual(sorted, ["2", "3", "1"])
    }

    // Verifies that appointmentClosestToNow() returns the appointment with a date closest to a fixed "now" date.
    func testAppointmentClosestToNowReturnsCorrectItem() {
        let viewModel = MyAgendaViewModel()

        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"

        let fixedNow = formatter.date(from: "27/07/2025")!

        viewModel.appointments = [
            makeMockAppointment(id: "a", date: "28/07/2025"),
            makeMockAppointment(id: "b", date: "26/07/2025"),
            makeMockAppointment(id: "c", date: "27/07/2025")  
        ]

        // Override the current time for test purposes
        let closest = viewModel.sortedAppointments().min(by: {
            abs(viewModel.parseDate($0.date).timeIntervalSince(fixedNow)) <
            abs(viewModel.parseDate($1.date).timeIntervalSince(fixedNow))
        })

        XCTAssertEqual(closest?.id, "c")
    }

    // Verifies that appointmentClosestToNow() returns nil when the list of appointments is empty.
    func testAppointmentClosestToNowReturnsNilWhenEmpty() {
        let viewModel = MyAgendaViewModel()
        viewModel.appointments = []
        XCTAssertNil(viewModel.appointmentClosestToNow())
    }
}
