import Foundation

struct Flashcard: Encodable {
    var question: String
    var answer: String
}

struct FlashcardSet: Encodable {
    var title: String
    var flashcards: [Flashcard]
}

enum FlashcardOption: String {
    case createNew = "1"
    case reviewExisting = "2"
    case exit = "3"
}

func getUserInput(prompt: String) -> String {
    print(prompt, terminator: ": ")
    return readLine() ?? ""
}

func createFlashcardsManually() -> FlashcardSet {
    print("Enter the title of the flashcard set:")
    let title = readLine() ?? ""

    var flashcards: [Flashcard] = []

    repeat {
        let question = getUserInput(prompt: "Enter a question")
        let answer = getUserInput(prompt: "Enter the answer")

        flashcards.append(Flashcard(question: question, answer: answer))

        let isComplete = getUserInput(prompt: "Are the flashcards complete? (yes/no)").lowercased() == "yes"

        if isComplete {
            break
        }

    } while true

    let flashcardSet = FlashcardSet(title: title, flashcards: flashcards)
    saveFlashcardSetAsJSON(flashcardSet)

    return flashcardSet
}

func createFlashcardsFromJSON() -> FlashcardSet {
    print("Enter the title of the flashcard set:")
    let title = readLine() ?? ""

    print("Enter the path to the JSON file:")
    if let path = readLine(),
       let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
       let jsonArray = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: String]] {

        let flashcards = jsonArray.map { Flashcard(question: $0["question"] ?? "", answer: $0["answer"] ?? "") }
        return FlashcardSet(title: title, flashcards: flashcards)
    } else {
        print("Invalid JSON file.")
        return FlashcardSet(title: "", flashcards: [])
    }
}

func saveFlashcardSetAsJSON(_ flashcardSet: FlashcardSet) {
    do {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let jsonData = try encoder.encode(flashcardSet)

        // Get the current working directory
        let currentDirectory = FileManager.default.currentDirectoryPath

        // Create a "Resources" directory if it doesn't exist
        let resourcesDirectory = currentDirectory + "Sources/Resources"
        try FileManager.default.createDirectory(atPath: resourcesDirectory, withIntermediateDirectories: true, attributes: nil)

        // Save the JSON file within the "Resources" directory
        let fileURL = URL(fileURLWithPath: resourcesDirectory).appendingPathComponent("\(flashcardSet.title).json")
        try jsonData.write(to: fileURL)

        print("Flashcard set saved as JSON: \(fileURL.path)")
    } catch {
        print("Error saving flashcard set as JSON: \(error.localizedDescription)")
    }
}

func reviewFlashcardSet(_ flashcardSet: FlashcardSet) {
    print("Reviewing flashcards for set '\(flashcardSet.title)':")

    for card in flashcardSet.flashcards {
        print("---")
        print("Question: \(card.question)")
        _ = getUserInput(prompt: "Press Enter to reveal the answer")
        print("Answer: \(card.answer)")
    }
}


func main() {
    var flashcardSets: [FlashcardSet] = []

    while true {
        print("\nFlashcard App")
        print("1. Create new flashcards")
        print("2. Review existing flashcards")
        print("3. Exit")

        if let option = FlashcardOption(rawValue: getUserInput(prompt: "Choose an option")) {
            switch option {
            case .createNew:
                print("1. Enter flashcards manually")
                print("2. Enter flashcards from JSON file")

                let createOption = getUserInput(prompt: "Choose an option")

                switch createOption {
                case "1":
                    let flashcardSet = createFlashcardsManually()
                    flashcardSets.append(flashcardSet)
                case "2":
                    let flashcardSet = createFlashcardsFromJSON()
                    if flashcardSet.title != "" {
                        flashcardSets.append(flashcardSet)
                    }
                default:
                    break
                }

            case .reviewExisting:
                if flashcardSets.isEmpty {
                    print("No flashcard sets to review. Create new flashcards first.")
                } else {
                    print("Select a flashcard set to review:")
                    for (index, set) in flashcardSets.enumerated() {
                        print("\(index + 1). \(set.title)")
                    }

                    if let setIndex = Int(getUserInput(prompt: "Enter the set number")) {
                        if setIndex > 0 && setIndex <= flashcardSets.count {
                            let selectedSet = flashcardSets[setIndex - 1]
                            reviewFlashcardSet(selectedSet)
                        } else {
                            print("Invalid set number.")
                        }
                    } else {
                        print("Invalid input.")
                    }
                }

            case .exit:
                print("Exiting Flashcard App.")
                exit(0)
            }
        } else {
            print("Invalid option. Please choose 1, 2, or 3.")
        }
    }
}

main()
