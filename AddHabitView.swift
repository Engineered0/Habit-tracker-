import SwiftUI

struct AddHabitView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var habitViewModel: HabitViewModel
    @State private var title: String = ""
    @State private var description: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Habit")) {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description)
                }
                Section {
                    Button(action: {
                        habitViewModel.addHabit(title: title, description: description)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Add Habit")
                            .font(.headline)
                            .foregroundColor(.white) // Text color
                            .padding()
                            .background(Color.blue) // Background color
                            .cornerRadius(8) // Corner radius
                            .shadow(radius: 5) // Add shadow
                    }
                }
            }
            .navigationBarTitle("New Habit", displayMode: .inline)
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

