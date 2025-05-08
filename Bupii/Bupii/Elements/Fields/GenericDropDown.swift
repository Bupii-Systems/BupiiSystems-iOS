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
    var placeholder: String = "Selecione a data"

    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .foregroundColor(self.isExpanded ? Color(AppColor.brand).opacity(0.2) : .white)
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
                DatePicker("", selection: $selectedDate, in: Date()..., displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .labelsHidden()
                    .padding()
                    .tint(Color(AppColor.brand))
                    .background(Color.white)
                    .cornerRadius(8)
            }
        }
        .padding(.horizontal, 16)
    }

    var selectedDateFormatted: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: selectedDate)
    }
}

// MARK: - Time Dropdown

struct TimeDropDown: View {
    @Binding var selectedTime: Date
    @State private var isExpanded = false
    var placeholder: String = "Selecione o horário"

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
                DatePicker("", selection: $selectedTime, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .padding()
                    .tint(Color(AppColor.brand))
                    .background(Color.white)
                    .cornerRadius(8)
            }
        }
        .padding(.horizontal, 16)
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
