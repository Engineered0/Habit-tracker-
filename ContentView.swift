import SwiftUI

struct ContentView: View {
    @StateObject private var habitViewModel = HabitViewModel()
    @State private var showingAddHabitView = false
    @State private var showingUserNameView = false
    @State private var showingTrackerView = false

    var body: some View {
        NavigationView {
            VStack {
                if habitViewModel.userName.isEmpty {
                    UserNameView(habitViewModel: habitViewModel)
                } else {
                    Text("Hello \(habitViewModel.userName)")
                        .font(.largeTitle)
                        .padding()
                    List {
                        ForEach(habitViewModel.habits) { habit in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(habit.title)
                                        .font(.headline)
                                    Text(habit.description)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                    if habit.isCompleted {
                                        Text("Completed on \(habit.completionDates.last!, formatter: DateFormatter.shortDate)")
                                            .font(.footnote)
                                            .foregroundColor(.green)
                                    }
                                }
                                Spacer()
                                if habit.isCompleted {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                } else {
                                    Button(action: {
                                        withAnimation {
                                            habitViewModel.toggleCompletion(for: habit)
                                            showCompletionAnimation()
                                        }
                                    }) {
                                        Image(systemName: "circle")
                                            .foregroundColor(.blue) // Adjust color here
                                    }
                                }
                            }
                            .strikethrough(habit.isCompleted, color: .green)
                            .opacity(habit.isCompleted ? 0.6 : 1)
                        }
                    }
                    .listStyle(PlainListStyle())
                    .navigationBarTitle("Habit Tracker")
                    .navigationBarItems(trailing:
                        HStack {
                            Button(action: {
                                showingAddHabitView = true
                            }) {
                                Image(systemName: "plus")
                                    .foregroundColor(.blue) // Adjust color here
                                    .padding()
                                    .cornerRadius(8) // Corner radius
                                    .shadow(radius: 5) // Add shadow
                            }
                            Button(action: {
                                showingTrackerView = true
                            }) {
                                Image(systemName: "chart.bar.fill")
                                    .foregroundColor(.blue) // Adjust color here
                                    .padding()
                                    .cornerRadius(8) // Corner radius
                                    .shadow(radius: 5) // Add shadow
                            }
                        }
                    )
                }
            }
            .sheet(isPresented: $showingAddHabitView) {
                AddHabitView(habitViewModel: habitViewModel)
            }
            .sheet(isPresented: $showingTrackerView) {
                TrackerView(habitViewModel: habitViewModel)
            }
        }
    }

    private func showCompletionAnimation() {
        // Show thumbs-up animation here
        // You can customize this animation as needed
    }
}

