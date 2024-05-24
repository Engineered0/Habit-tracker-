import SwiftUI

struct TrackerView: View {
    @ObservedObject var habitViewModel: HabitViewModel
    @State private var selectedPeriod: Calendar.Component = .day

    var body: some View {
        VStack {
            Text("Habit Tracker")
                .font(.largeTitle)
                .padding()

            Picker("Period", selection: $selectedPeriod) {
                Text("Daily").tag(Calendar.Component.day)
                Text("Monthly").tag(Calendar.Component.month)
                Text("Yearly").tag(Calendar.Component.year)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            List {
                ForEach(habitViewModel.habits) { habit in
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
                    .strikethrough(habit.isCompleted, color: .green)
                    .opacity(habit.isCompleted ? 0.6 : 1)
                }
            }
            .listStyle(PlainListStyle())

            Text("Completed Habits: \(habitViewModel.getCompletionCount(for: selectedPeriod))")
                .font(.headline)
                .padding()
        }
    }
}

