import SwiftUI

struct UserNameView: View {
    @State private var userName: String = ""
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var habitViewModel: HabitViewModel

    var body: some View {
        VStack {
            Text("Enter Your Name")
                .font(.largeTitle)
                .padding()
            TextField("Name", text: $userName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button(action: {
                habitViewModel.saveUserName(name: userName)
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Save")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

