//
//  GenericDropDown.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 25/04/2025.
//

import SwiftUI

struct GenericDropDown: View {
    @Binding var selection: String
    @State private var isExpanded = false
    var leftImageName: String
    var options: [String]
    var placeholder: String

    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .foregroundColor(self.isExpanded ? Color(AppColor.brand).opacity(0.2) : .white)
                    .frame(height: 56)
                    .cornerRadius(8)

                HStack {
                    Image(leftImageName)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .padding(.leading, 16)
                        .foregroundStyle(AppColor.brand)

                    ZStack {
                        if selection.isEmpty {
                            Text(placeholder)
                                .foregroundColor(Color(AppColor.text))
                                .font(.custom("Inter-Regular", size: 16))
                                .padding(.leading, 8)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }

                        Text(selection)
                            .font(.custom("Inter-Regular", size: 16))
                            .foregroundColor(Color(AppColor.text))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    Image("ArrowDown")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 16)
                        .padding(.bottom, 10)
                        .onTapGesture {
                            withAnimation {
                                isExpanded.toggle()
                            }
                        }
                }
                .onTapGesture {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }
            }

            if isExpanded {
                VStack {
                    ForEach(options, id: \.self) { option in
                        Text(option)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.white)
                            .foregroundColor(Color(AppColor.text))
                            .onTapGesture {
                                selection = option
                                withAnimation {
                                    isExpanded = false
                                }
                            }
                    }
                }
                .background(Color.white)
                .cornerRadius(8)
            }
        }
        .padding(.horizontal, 16)
    }
}


struct DateDropDown: View {
    @Binding var selectedDate: Date
    @State private var isExpanded = false
    @State private var showToast = false
    @State private var didAppearOnce = false

    var placeholder: String = "Selecione a data"
    var allowedWeekdays: [Int] = [2, 3, 4, 5, 6]

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Rectangle()
                    .foregroundColor(isExpanded ? Color(AppColor.brand).opacity(0.2) : .white)
                    .frame(height: 56)
                    .cornerRadius(8)

                HStack {
                    Image("Calendar")
                        .renderingMode(.template)
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .padding(.leading, 16)
                        .foregroundStyle(AppColor.brand)

                    Text(selectedDateFormatted)
                        .font(.custom("Inter-Regular", size: 16))
                        .foregroundColor(Color(AppColor.text))
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Image("ArrowDown")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 16)
                        .padding(.bottom, 10)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }
            }

            if isExpanded {
                DatePicker("", selection: $selectedDate, in: validDateRange, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .labelsHidden()
                    .padding()
                    .tint(Color(AppColor.brand))
                    .background(Color.white)
                    .cornerRadius(8)
            }

            if showToast {
                ToastView(message: "Esta data não está disponível. Selecionamos outra para você.")
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            showToast = false
                        }
                    }
            }
        }
        .padding(.horizontal, 16)
        .onAppear {
            // Ajusta a data se inválida, mas sem mostrar o toast
            let weekday = Calendar.current.component(.weekday, from: selectedDate)
            if !allowedWeekdays.contains(weekday),
               let nextValid = nextValidDate(from: selectedDate) {
                selectedDate = nextValid
            }

            didAppearOnce = true
        }
        .onChange(of: selectedDate) { newValue in
            let weekday = Calendar.current.component(.weekday, from: newValue)
            if !allowedWeekdays.contains(weekday),
               let nextValid = nextValidDate(from: newValue) {
                selectedDate = nextValid

                // Mostra o toast apenas após a primeira aparição
                if didAppearOnce {
                    showToast = true
                }
            }
        }
    }

    var selectedDateFormatted: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: selectedDate)
    }

    var validDateRange: ClosedRange<Date> {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let future = calendar.date(byAdding: .month, value: 2, to: today) ?? today

        let validDates = stride(from: today, through: future, by: 86400).compactMap { date -> Date? in
            let weekday = calendar.component(.weekday, from: date)
            return allowedWeekdays.contains(weekday) ? date : nil
        }

        guard let first = validDates.first, let last = validDates.last else {
            return today...today
        }

        return first...last
    }

    func nextValidDate(from start: Date) -> Date? {
        let calendar = Calendar.current
        return stride(from: start, through: start.addingTimeInterval(86400 * 60), by: 86400).first { date in
            allowedWeekdays.contains(calendar.component(.weekday, from: date))
        }
    }
}


// MARK: - Time Dropdown

struct TimeDropDown: View {
    @Binding var selectedTime: Date
    @State private var isExpanded = false
    @State private var showToast = false
    var placeholder: String = "Selecione o horário"
    var openingHour: Int = 9
    var closingHour: Int = 20

    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .foregroundColor(self.isExpanded ? Color(AppColor.brand).opacity(0.2) : .white)
                    .frame(height: 56)
                    .cornerRadius(8)

                HStack {
                    Image("Clock")
                        .renderingMode(.template)
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .padding(.leading, 16)
                        .foregroundStyle(AppColor.brand)

                    Text(selectedTimeFormatted)
                        .font(.custom("Inter-Regular", size: 16))
                        .foregroundColor(Color(AppColor.text))
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Image("ArrowDown")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 16)
                        .padding(.bottom, 10)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }
            }

            if isExpanded {
                DatePicker("", selection: Binding(get: {
                    selectedTime
                }, set: { newTime in
                    let calendar = Calendar.current
                    let today = calendar.startOfDay(for: Date())
                    let open = calendar.date(bySettingHour: openingHour, minute: 0, second: 0, of: today) ?? Date()
                    let close = calendar.date(bySettingHour: closingHour, minute: 0, second: 0, of: today) ?? Date()

                    if newTime >= open && newTime <= close {
                        selectedTime = newTime
                    } else {
                        showToast = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showToast = false
                        }
                    }
                }), displayedComponents: .hourAndMinute)
                .datePickerStyle(.wheel)
                .labelsHidden()
                .padding()
                .tint(Color(AppColor.brand))
                .background(Color.white)
                .cornerRadius(8)
            }
        }
        .padding(.horizontal, 16)
        .overlay(
            VStack {
                if showToast {
                    ToastView(message: "Horário fora do funcionamento")
                        .padding(.top, -40)
                }
                Spacer()
            }, alignment: .top
        )
    }

    var selectedTimeFormatted: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: selectedTime)
    }
}


// MARK: - Previews
//
//#Preview("DateDropDown") {
//    StatefulPreviewWrapper(Date()) { binding in
//        DateDropDown(selectedDate: binding)
//            .preferredColorScheme(.light)
//    }
//}

//#Preview("TimeDropDown") {
//    StatefulPreviewWrapper(Date()) { binding in
//        TimeDropDown(selectedTime: binding)
//            .preferredColorScheme(.light)
//    }
//}

//#Preview {
//    GenericDropDown(
//        leftImageName: "Calendar",
//        options: ["Limited Access", "Full Access", "Restricted Access"],
//        placeholder: "Escolha a opção"
//    )
//    .preferredColorScheme(.dark)
//}

struct ToastView: View {
    let message: String

    var body: some View {
        Text(message)
            .font(.custom("Inter-Regular", size: 14))
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(Color.black.opacity(0.8))
            .foregroundColor(.white)
            .cornerRadius(10)
            .transition(.opacity)
            .zIndex(999)
    }
}

