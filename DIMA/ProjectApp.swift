import SwiftUI
import SwiftData

@main
struct ProjectApp: App {
    init() {
            loadEnvironmentVariables()
        }
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(sharedModelContainer)
    }
}

func loadEnvironmentVariables() {
    guard let filePath = Bundle.main.path(forResource: ".env", ofType: nil) else {
        print(".env file not found")
        return
    }

    do {
        let contents = try String(contentsOfFile: filePath)
        let lines = contents.split(separator: "\n")

        for line in lines {
            let keyValue = line.split(separator: "=", maxSplits: 1)
            if keyValue.count == 2 {
                let key = String(keyValue[0])
                let value = String(keyValue[1])
                setenv(key, value, 1)
            }
        }
    } catch {
        print("Error reading .env file")
    }
}
