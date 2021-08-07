//
//  ContentView.swift
//  TestProject
//
//  Created by wsa2021 on 02.08.2021.
//

import SwiftUI
import ContactsUI

struct ContentView: View {
    @State var contacts: [CNContact] = []
    var nameFormatter: CNContactFormatter = {
        let formatter = CNContactFormatter()
        formatter.style = .fullName
        return formatter
    }()
    @State var showVoice = false
    @State var usersCount = "5"
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            if showVoice {
                Text("Join Voice with \(usersCount) users")
            }
            ForEach(contacts, id: \.self) { contact in
                VStack(alignment: .center) {
                    if let name = nameFormatter.string(from: contact) {
                        Text(name)
                    }
                    if let phoneNumber = contact.phoneNumbers.first?.value.stringValue {
                        Text(phoneNumber)
                    }
                }.padding()
            }
        }.frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        .onAppear {
            self.showVoice = false
            loadContacts()
        }
        .onOpenURL { (url) in
            if url.absoluteString.contains("widget-deeplink://voice") {
                self.showVoice = true
                self.usersCount = "\(url.absoluteString.last ?? "5")"
            }
        }
    }
    
    func loadContacts() {
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { granted, error in
            guard granted else {
                print(error?.localizedDescription ?? "Unknown error")
                return
            }
            
            let request = CNContactFetchRequest(keysToFetch: [CNContactPhoneNumbersKey as CNKeyDescriptor, CNContactIdentifierKey as CNKeyDescriptor, CNContactFormatter.descriptorForRequiredKeys(for: .fullName)])
            do {
                try store.enumerateContacts(with: request) { contact, stop in
                    self.contacts.append(contact)
                }
            } catch let fetchError {
                print(fetchError)
            }
        }
    }
}
