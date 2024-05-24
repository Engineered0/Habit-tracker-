import Foundation

struct Habit: Identifiable, Codable {
    let id = UUID()
    let title: String
    let description: String
    var isCompleted: Bool = false
    var completionDates: [Date] = []
}

