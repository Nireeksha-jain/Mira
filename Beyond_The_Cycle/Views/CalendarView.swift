import SwiftUI

struct CalendarView: View {
    @State var weeks: [[CycleDay?]] = []
    let selectedDayNumber = 21 // matches Figma reference; wire to real "today" logic later

    let cellSpacing: CGFloat = 4
    let rowSpacing: CGFloat = 8
    let horizontalPadding: CGFloat = 16

    var body: some View {
        GeometryReader { geo in
            // Compute cell width dynamically so the grid always fills the screen width,
            // regardless of device size. 7 columns, 6 gaps between them.
            let availableWidth = geo.size.width - (horizontalPadding * 2)
            let cellWidth = (availableWidth - cellSpacing * 6) / 7
            let cellHeight = cellWidth * 0.85 // keeps pills slightly shorter than wide

            VStack(alignment: .leading, spacing: 12) {

                Text(monthTitle())
                    .font(.dsHeadingEB32)
                    .foregroundStyle(Color.dsBlack)
                    .padding(.top)

                Text("You're in the Ovulation phase")
                    .font(.dsHeadingB15)
                    .foregroundStyle(Color.greenM)

                // Weekday header row
                HStack(spacing: cellSpacing) {
                    ForEach(Array(["M", "T", "W", "T", "F", "S", "S"].enumerated()), id: \.offset) { _, label in
                        Text(label)
                            .font(.dsHeadingB12)
                            .foregroundStyle(Color.dsBlack)
                            .frame(width: cellWidth)
                    }
                }
                .padding(.top, 8)

                // Week rows, each with merged same-phase pill segments
                VStack(spacing: rowSpacing) {
                    ForEach(0..<weeks.count, id: \.self) { weekIndex in
                        weekRow(weeks[weekIndex], cellWidth: cellWidth, cellHeight: cellHeight)
                    }
                }

                Spacer(minLength: 0)

                HStack {
                    Spacer()
                    Button {
                        print("Log your cycle tapped")
                    } label: {
                        Text("+ Log your cycle")
                            .font(.dsHeadingB15)
                            .foregroundStyle(Color.dsWhite)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 14)
                            .background(Color.greenM)
                            .clipShape(Capsule())
                    }
                    Spacer()
                }
                .padding(.bottom, 30)
            }
            .padding(.horizontal, horizontalPadding)
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .background(Color.dsBackground)
        .onAppear {
            buildWeeks()
        }
    }

    // MARK: - Week row with merged consecutive same-phase segments
    func weekRow(_ week: [CycleDay?], cellWidth: CGFloat, cellHeight: CGFloat) -> some View {
        HStack(spacing: cellSpacing) {
            ForEach(mergedSegments(for: week), id: \.start) { segment in
                ZStack {
                    if let phase = segment.phase {
                        RoundedRectangle(cornerRadius: DSRadius.full)
                            .fill(colorForPhase(phase))
                    }

                    HStack(spacing: 0) {
                        ForEach(segment.start...segment.end, id: \.self) { slot in
                            if let day = week[slot] {
                                dayCell(day, cellHeight: cellHeight)
                                    .frame(width: cellWidth)
                            } else {
                                Color.clear.frame(width: cellWidth)
                            }
                        }
                    }
                }
                .frame(width: cellWidth * CGFloat(segment.end - segment.start + 1)
                             + cellSpacing * CGFloat(segment.end - segment.start),
                       height: cellHeight)
            }
        }
    }

    func dayCell(_ day: CycleDay, cellHeight: CGFloat) -> some View {
        let dayNumber = Calendar.current.component(.day, from: day.date)
        let isSelected = dayNumber == selectedDayNumber
        let ringSize = cellHeight * 0.8

        return ZStack {
            if isSelected {
                Circle()
                    .fill(Color.dsWhite)
                    .overlay(Circle().stroke(Color.greenM, lineWidth: 2))
                    .frame(width: ringSize, height: ringSize)
            }

            Text("\(dayNumber)")
                .font(.system(size: 13, weight: .bold))
                .foregroundStyle(Color.dsBlack)
        }
        .frame(height: cellHeight)
    }

    // MARK: - Segment model: a run of consecutive slots sharing the same phase (or nil gap)
    struct Segment {
        let start: Int
        let end: Int
        let phase: CyclePhase?
    }

    func mergedSegments(for week: [CycleDay?]) -> [Segment] {
        var segments: [Segment] = []
        var index = 0

        while index < week.count {
            let currentPhase = week[index]?.phase
            var end = index

            while end + 1 < week.count && week[end + 1]?.phase == currentPhase {
                end += 1
            }

            segments.append(Segment(start: index, end: end, phase: currentPhase))
            index = end + 1
        }

        return segments
    }

    // MARK: - Data building
    func monthTitle() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter.string(from: Date())
    }

    func buildWeeks() {
        let calendar = Calendar.current
        let today = Date()
        guard let monthStart = calendar.date(from: calendar.dateComponents([.year, .month], from: today)),
              let range = calendar.range(of: .day, in: .month, for: monthStart) else { return }

        let firstWeekday = calendar.component(.weekday, from: monthStart)
        let leadingEmptyCount = (firstWeekday + 5) % 7

        var flatDays: [CycleDay?] = Array(repeating: nil, count: leadingEmptyCount)

        for dayNum in range {
            guard let date = calendar.date(byAdding: .day, value: dayNum - 1, to: monthStart) else { continue }
            let phase: CyclePhase
            switch dayNum % 28 {
            case 0...5: phase = .menstrual
            case 6...13: phase = .follicular
            case 14...16: phase = .ovulation
            default: phase = .luteal
            }
            flatDays.append(CycleDay(date: date, phase: phase))
        }

        while flatDays.count % 7 != 0 {
            flatDays.append(nil)
        }

        weeks = stride(from: 0, to: flatDays.count, by: 7).map {
            Array(flatDays[$0..<min($0 + 7, flatDays.count)])
        }
    }

    func colorForPhase(_ phase: CyclePhase) -> Color {
        switch phase {
        case .menstrual: return Color.cycleRed
        case .follicular: return Color.cycleBlue
        case .ovulation: return Color.cycleGreen
        case .luteal: return Color.cycleYellow
        case .unknown: return Color.dsDarkerBg
        }
    }
}

#Preview {
    CalendarView()
}
