import Foundation

class HabitViewModel: ObservableObject {
    @Published var habits: [Habit] = []
    @Published var userName: String = UserDefaults.standard.string(forKey: "userName") ?? ""

    init() {
        loadHabits()
    }

    func addHabit(title: String, description: String) {
        let newHabit = Habit(title: title, description: description)
        habits.insert(newHabit, at: 0) // Insert at the beginning
        saveHabits()
    }

    func toggleCompletion(for habit: Habit) {
        if let index = habits.firstIndex(where: { $0.id == habit.id }) {
            habits[index].isCompleted = true
            habits[index].completionDates.append(Date())
            saveHabits()
        }
    }

    var completedHabitsCount: Int {
        habits.filter { $0.isCompleted }.count
    }

    func getCompletionCount(for period: Calendar.Component) -> Int {
        let now = Date()
        return habits.flatMap { $0.completionDates }.filter {
            Calendar.current.isDate($0, equalTo: now, toGranularity: period)
        }.count
    }

    func saveUserName(name: String) {
        userName = name
        UserDefaults.standard.set(name, forKey: "userName")
    }

    private func saveHabits() {
        if let encoded = try? JSONEncoder().encode(habits) {
            UserDefaults.standard.set(encoded, forKey: "habits")
        }
    }

    private func loadHabits() {
        if let savedHabits = UserDefaults.standard.data(forKey: "habits") {
            if let decodedHabits = try? JSONDecoder().decode([Habit].self, from: savedHabits) {
                habits = decodedHabits
            }
        }
    }
}
