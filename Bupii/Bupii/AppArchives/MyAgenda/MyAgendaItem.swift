//
//  MyAgendaItem.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 25/07/2025.
//

import SwiftUI

struct MyAgendaItem: View {
    var myAgendaView: MyAgendaView = MyAgendaView()
    
    var body: some View {
        VStack {
            Text("Meus agendamentos:")
                .font(.custom("Inter-Bold", size: 16))
                .foregroundStyle(Color(AppColor.text))
                .padding(.top, 141)
                .padding(.leading, 16)
                .frame(maxWidth: .infinity, alignment: .leading)

            if myAgendaView.appointments.isEmpty {
                Text("Nenhum agendamento encontrado.")
                    .font(.custom("Inter-Regular", size: 16))
                    .foregroundStyle(.gray)
                    .padding(.top, 24)
            } else {
                ScrollViewReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 16) {
                            ForEach(myAgendaView.sortedAppointments(), id: \.id) { appointment in
                                AppointmentCard(appointment: appointment) {
                                    if let id = appointment.id {
                                        myAgendaView.deleteAppointment(id: id)
                                    }
                                }
                                .frame(width: UIScreen.main.bounds.width - 32)
                                .id(appointment.id)
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                    .padding(.top, 19)
                    .onAppear {
                        if let closest = myAgendaView.appointmentClosestToNow(),
                           let id = closest.id {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                withAnimation {
                                    proxy.scrollTo(id, anchor: .center)
                                }
                            }
                        }
                    }
                }
            }

            Text("Produtos vendidos nessa unidade:")
                .font(.custom("Inter-Bold", size: 16))
                .foregroundStyle(Color(AppColor.text))
                .padding(.top, 24)
                .padding(.leading, 16)
                .frame(maxWidth: .infinity, alignment: .leading)

            ProductGridView()
            Spacer().frame(height: 160)
        }
    }
}

#Preview {
    MyAgendaItem()
}
