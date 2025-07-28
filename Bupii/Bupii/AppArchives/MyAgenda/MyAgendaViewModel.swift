//
//  MyAgendaViewModel.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 27/07/2025.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

// MARK: - ViewModel
final class MyAgendaViewModel: ObservableObject {
    @Published var appointments: [Appointment] = []

    init() {
        fetchAppointments()
    }

    func fetchAppointments() {
        guard let userId = Auth.auth().currentUser?.uid else { return }

        Firestore.firestore()
            .collection("appointments")
            .whereField("userId", isEqualTo: userId)
            .addSnapshotListener { snapshot, error in
                if let documents = snapshot?.documents {
                    DispatchQueue.main.async {
                        self.appointments = documents.compactMap { doc in
                            try? doc.data(as: Appointment.self)
                        }
                    }
                } else {
                    print("Error to get data: \(error?.localizedDescription ?? "Unknow")")
                }
            }
    }

    func sortedAppointments() -> [Appointment] {
        appointments.sorted {
            parseDate($0.date) < parseDate($1.date)
        }
    }

    func appointmentClosestToNow() -> Appointment? {
        let now = Date()
        return sortedAppointments().min(by: {
            abs(parseDate($0.date).timeIntervalSince(now)) < abs(parseDate($1.date).timeIntervalSince(now))
        })
    }

    func deleteAppointment(id: String) {
        Firestore.firestore().collection("appointments").document(id).delete { error in
            if let error = error {
                print("Error to delete: \(error.localizedDescription)")
            } else {
                self.appointments.removeAll { $0.id == id }
            }
        }
    }

     func parseDate(_ string: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.date(from: string) ?? Date.distantFuture
    }
}
