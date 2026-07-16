
import Foundation
 
struct CycleDay: Identifiable {
    let id = UUID()
    let date: Date
    var phase: CyclePhase
    var stepCount: Int?
    var sleepHours: Double?
}
 
enum CyclePhase {
    case menstrual, follicular, ovulation, luteal, unknown
 
    var color: String {
        switch self {
        case .menstrual: return "cycleRed"
        case .follicular: return "cycleBlue"
        case .ovulation: return "cycleGreen"
        case .luteal: return "cycleYellow"
        case .unknown: return "systemBackground"
        }
    }
}
 
