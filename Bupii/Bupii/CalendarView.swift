import UIKit
import CalendarKit
import SwiftUI

// MARK: - UIKit Calendar Controller com CalendarKit

final class CalendarViewController: DayViewController {
    private let customEventDataSource = CustomEventDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = customEventDataSource
        self.reloadData()
    }
}

// MARK: - EventDataSource separado

final class CustomEventDataSource: EventDataSource {
    func eventsForDate(_ date: Date) -> [EventDescriptor] {
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        formatter.timeZone = TimeZone(identifier: "Europe/Lisbon")!

        // Simulando dados vindos do back-end
        let rawEvents: [[String: String]] = [
            ["professional": "Pedro", "start": "2025-05-18 12:00", "end": "2025-05-18 13:00"],
            ["professional": "Danilo", "start": "2025-05-18 12:00", "end": "2025-05-18 13:00"],
            ["professional": "Ana",    "start": "2025-05-18 12:00", "end": "2025-05-18 13:00"],
            ["professional": "Pedro", "start": "2025-05-18 14:00", "end": "2025-05-18 15:00"],
            ["professional": "Danilo", "start": "2025-05-18 15:00", "end": "2025-05-18 16:00"],
            ["professional": "Ana",    "start": "2025-05-18 16:00", "end": "2025-05-18 17:00"]
        ]

        return rawEvents.compactMap { dict in
            guard
                let startStr = dict["start"],
                let endStr = dict["end"],
                let start = formatter.date(from: startStr),
                let end = formatter.date(from: endStr),
                calendar.isDate(start, inSameDayAs: date)
            else {
                return nil
            }

            let event = Event()
            event.dateInterval = DateInterval(start: start, end: end)
            let name = dict["professional"] ?? "Desconhecido"
            event.text = "\(name) - Reunião"

            switch name {
            case "Pedro":
                event.color = .systemBlue
            case "Danilo":
                event.color = .systemRed
            case "Ana":
                event.color = .systemGreen
            default:
                event.color = .gray
            }

            event.textColor = .white
            return event
        }
    }
}

// MARK: - SwiftUI Wrapper

struct CalendarWrapperView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> CalendarViewController {
        return CalendarViewController()
    }

    func updateUIViewController(_ uiViewController: CalendarViewController, context: Context) {}
}

// MARK: - Hosting Controller para UIKit usar

final class CalendarHostingController: UIHostingController<CalendarWrapperView> {
    init() {
        super.init(rootView: CalendarWrapperView())
    }

    @objc required dynamic init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        rootView = CalendarWrapperView()
    }
}

// MARK: - UIViewControllerRepresentable Wrapper se quiser chamar como View

struct CalendarHostingWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> CalendarHostingController {
        return CalendarHostingController()
    }

    func updateUIViewController(_ uiViewController: CalendarHostingController, context: Context) {}
}
