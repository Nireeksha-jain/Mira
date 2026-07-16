import SwiftUI

struct ContentView: View {
    // Home is tag 1 — set as initial selection so app opens on Home,
    // while tab bar order stays calendar/home/insight matching the Figma layout.
    @State private var selectedTab = 1

    var body: some View {
        TabView(selection: $selectedTab) {
            CalendarView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("calendar")
                }
                .tag(0)

            HomeView()
                .tabItem {
                    Image(systemName: "circle.dashed")
                    Text("home")
                }
                .tag(1)

            InsightView()
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("insight")
                }
                .tag(2)
        }
        .tint(Color.olive)
    }
}

#Preview {
    ContentView()
}
