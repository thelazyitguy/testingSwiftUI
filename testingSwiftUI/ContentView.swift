//
//  ContentView.swift
//  testingSwiftUI
//
//  Created by Austin Pape on 2/24/21.
//

import SwiftUI

class Bindings: ObservableObject {
    static let shared = Bindings()
    // Logging
    @Published var logText: String = "Test"
    static func log(_ s: String) {
        shared.logText = shared.logText + s + "\n"
    }
    // Button
    @Published var buttonText: String = "Unsupported"
    @Published var buttonDisabled: Bool = true
    
}

struct TextView: UIViewRepresentable {
    @Binding var text: String

    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        //view.font = UIFont(name:"Roboto Mono",size:11) Font is currently not imported
        view.backgroundColor = UIColor.clear
        view.isScrollEnabled = true
        view.isEditable = false
        view.isUserInteractionEnabled = false
        return view
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        uiView.scrollRangeToVisible(NSMakeRange(uiView.text.count - 1, 1))
    }
}

struct ContentView: View {

    enum Tab {
        case Jailbreak
        case Settings
        case Credits
    }

    @State private var selection: Tab = .Jailbreak
    @ObservedObject var binds = Bindings.shared
    
    init(){
            UITableView.appearance().backgroundColor = .clear
        }

    var body: some View {
        TabView(selection: $selection) {
            NavigationView() {
                Form {
                    Section {
                        TextView(text: $binds.logText)
                            .frame(height: 500)
                    }
                    .background(Color.black)
                    .cornerRadius(15)
            Section{
                Button(action: {
                print("Delete tapped!")
                }){
                    HStack {
                        Image(systemName: "aqi.medium")
                            .font(.title)
                        Text("Jailbreak")
                            .fontWeight(.semibold)
                            .font(.title)
                    }
                    
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .bottom)
                    .padding()
                    .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [Color("DarkGreen"), Color("LightGreen")]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(40)
                    .padding(.horizontal, 75)
                }
                //Spacer()
                .padding(0.0)
                    }
            .background(Color.clear)
            }
            }
            .tabItem {
                Label("Jailbreak", systemImage: "aqi.low")
                    .foregroundColor(.black)
            }
            .tag(Tab.Jailbreak)
            
            NavigationView {
                Text("Settings Page")
            }
            .tabItem {
                Label("Settings", systemImage: "gearshape")
            }
            .tag(Tab.Settings)
            
            NavigationView {
                Text("Credits")
            }
            .tabItem {
                Label("Credits", systemImage: "gear")
            }
            .tag(Tab.Credits)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()

        }
    }
}



