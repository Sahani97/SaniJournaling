import SwiftUI

struct MainView: View {
    @State private var moodDayColors: [Int: Color] = [:]
    @State private var sleepDayColors: [Int: Color] = [:]
    @State private var gymDayColors: [Int: Color] = [:]
    @State private var readingDayColors: [Int: Color] = [:]

    @State private var activeScreen = "Mood"
    @State private var showAddEntry = false

    var body: some View {
        ZStack {
            TabView {
                MoodView(dayColors: $moodDayColors)
                    .tabItem {
                        Image("mood-nav")
                        Text("Mood")
                    }
                    .onAppear {
                        activeScreen = "Mood"
                    }

                SleepView(dayColors: $sleepDayColors)
                    .tabItem {
                        Image("sleep-nav")
                        Text("Sleep")
                    }
                    .onAppear {
                        activeScreen = "Sleep"
                    }

                Text("") // Leerer Platzhalter für den Plus-Button
                    .tabItem { Text("") }
                    .disabled(true)

                GymView(dayColors: $gymDayColors)
                    .tabItem {
                        Image("gym-nav")
                        Text("Gym")
                    }
                    .onAppear {
                        activeScreen = "Gym"
                    }

                ReadingView(dayColors: $readingDayColors)
                    .tabItem {
                        Image("reading-nav")
                        Text("Reading")
                    }
                    .onAppear {
                        activeScreen = "Reading"
                    }
            }

            // Plus-Button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        showAddEntry.toggle()
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color.black)
                                .frame(width: 60, height: 60)
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .font(.system(size: 30))
                        }
                    }
                    .offset(x: -170, y: -5)
                }
            }
        }
        .onAppear {
            loadAllDayColors()
        }
        .onChange(of: moodDayColors) { oldValue, newValue in
            saveMoodColors(newValue)
        }
        .onChange(of: sleepDayColors) { oldValue, newValue in
            saveSleepColors(newValue)
        }
        .onChange(of: gymDayColors) { oldValue, newValue in
            saveGymColors(newValue)
        }
        .onChange(of: readingDayColors) { oldValue, newValue in
            saveReadingColors(newValue)
        }
        .sheet(isPresented: $showAddEntry) {
            if activeScreen == "Mood" {
                AddEntryView(screenType: "Mood", dayColors: $moodDayColors)
            } else if activeScreen == "Sleep" {
                AddEntryView(screenType: "Sleep", dayColors: $sleepDayColors)
            } else if activeScreen == "Gym" {
                AddEntryView(screenType: "Gym", dayColors: $gymDayColors)
            } else if activeScreen == "Reading" {
                AddEntryView(screenType: "Reading", dayColors: $readingDayColors)
            }
        }
    }

    private func loadAllDayColors() {
        moodDayColors = PersistentStorage.load(forKey: "MoodColors2025")
        sleepDayColors = PersistentStorage.load(forKey: "SleepColors2025")
        gymDayColors = PersistentStorage.load(forKey: "GymColors2025")
        readingDayColors = PersistentStorage.load(forKey: "ReadingColors2025")
    }
    
    private func saveMoodColors(_ newValue: [Int: Color]) {
        PersistentStorage.save(dayColors: newValue, forKey: "MoodColors2025")
    }

    private func saveSleepColors(_ newValue: [Int: Color]) {
        PersistentStorage.save(dayColors: newValue, forKey: "SleepColors2025")
    }

    private func saveGymColors(_ newValue: [Int: Color]) {
        PersistentStorage.save(dayColors: newValue, forKey: "GymColors2025")
    }

    private func saveReadingColors(_ newValue: [Int: Color]) {
        PersistentStorage.save(dayColors: newValue, forKey: "ReadingColors2025")
    }
}
