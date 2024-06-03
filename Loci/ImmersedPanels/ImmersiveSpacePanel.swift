import Foundation
import SwiftUI
import RealityKit

struct PlaceColorPairView: View {
    let place: String
    let color: Color

    var body: some View {
        HStack {
            Circle()
                .fill(color)
                .frame(width: 20, height: 20)
            Text("\(place)")
                .padding(.leading, 10)
        }
    }
}

struct ImmersiveSpacePanel: View {
    @Binding var showImmersiveSpace: Bool
    @Binding var isHandlingImmersiveSpace: Bool
    @State var showObject: Bool = false
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace

    var body: some View {
        VStack {
            Text("Immersive Space Panel")
                .font(.largeTitle)
                .padding(.top, 50)

            Button(showImmersiveSpace ? "Close Immersive Space" : "Open Immersive Space") {
                if isHandlingImmersiveSpace { return }
                isHandlingImmersiveSpace = true
                Task {
                    if showImmersiveSpace {
                        await dismissImmersiveSpace()
                        showImmersiveSpace = false
                    } else {
                        switch await openImmersiveSpace(id: "ImmersiveSpace") {
                        case .opened:
                            showImmersiveSpace = true
                        case .error, .userCancelled:
                            showImmersiveSpace = false
                        @unknown default:
                            showImmersiveSpace = false
                        }
                    }
                    isHandlingImmersiveSpace = false
                }
            }
            .buttonStyle(.bordered)
            .padding()
            
            // Turn on/off 3D objects
            Button(showObject ? "Hide Objects" : "Show Objects") {
                showObject.toggle()
                Task {
                    await dismissImmersiveSpace()
                    if showObject {
                        await openImmersiveSpace(id: "ImmersiveSpace2")
                    } else {
                        await openImmersiveSpace(id: "ImmersiveSpace")
                    }
                    showImmersiveSpace = true
                    isHandlingImmersiveSpace = true
                }
            }
            .buttonStyle(.bordered)
            .padding()
            
            // Horizontal stack with color-coded panel and scrollable text
            HStack(alignment: .top) {
                // Place-Color Pairs
                VStack(alignment: .leading) {
                    PlaceColorPairView(place: "Medbay", color: .red)
                    PlaceColorPairView(place: "Security", color: .orange)
                    PlaceColorPairView(place: "Reactor", color: .yellow)
                    PlaceColorPairView(place: "Electrical", color: .green)
                    PlaceColorPairView(place: "Storage", color: .blue)
                    PlaceColorPairView(place: "Communicators", color: .blue.opacity(0.7))
                    PlaceColorPairView(place: "Navigation", color: .purple)
                    PlaceColorPairView(place: "Oxygen", color: .pink)
                    PlaceColorPairView(place: "Cafeteria", color: .green.opacity(0.7))
                    PlaceColorPairView(place: "Admin", color: .brown)
                }
                .padding()
                
                // Scrollable text component
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        Group {
                            Text("Medbay")
                                .font(.headline)
                            Text("1. What time did the man go to the dentist? Tooth hurt-y.")
                            Text("2. Why don’t skeletons fight each other? They don’t have the guts.")
                            Text("3. What do you call cheese that isn't yours? Nacho cheese.")
                            Text("4. How does a penguin build its house? Igloos it together.")
                            Text("5. Why did the scarecrow win an award? Because he was outstanding in his field.")
                        }
                        Group {
                            Text("Security")
                                .font(.headline)
                            Text("6. Where do birds stay when they travel? Someplace cheep.")
                            Text("7. What should you do if your puppy isn't feeling well? Take him to the dog-tor.")
                            Text("8. Why did the lamp get a promotion? It was really bright.")
                            Text("9. How do you make a robot angry? Keep pushing his buttons.")
                            Text("10. When is a car not a car? When it turns into a parking lot.")
                        }
                        Group {
                            Text("Reactor")
                                .font(.headline)
                            Text("11. Where did people hang out during medieval times? At knight clubs.")
                            Text("12. What do you call a happy cowboy? A jolly rancher.")
                            Text("13. What kind of bagel can travel? A plain bagel.")
                            Text("14. Why shouldn't you tell jokes to a duck? Because they'll quack up.")
                            Text("15. Why did the pony ask for a glass of water? Because it was a little horse.")
                        }
                        Group {
                            Text("Electrical")
                                .font(.headline)
                            Text("16. How can you tell if a pig is hot? It's bacon.")
                            Text("17. When does a joke become a dad joke? Well, during the delivery it becomes apparent.")
                            Text("18. Why did the computer catch cold? It left a window open.")
                            Text("19. What do you call a can opener that doesn't work? A can't opener.")
                            Text("20. What should you do if you meet a giant? Use big words.")
                        }
                        Group {
                            Text("Storage")
                                .font(.headline)
                            Text("21. What do you call a cow with two legs? Lean beef.")
                            Text("22. What do you call a fish with no eyes? Fsh.")
                            Text("23. Did you hear about the woman who couldn't stop collecting magazines? She had issues.")
                            Text("24. What do you call a man wearing a rug on his head? Matt.")
                            Text("25. 6:30 is my favorite time of the day. Hands down.")
                        }
                        Group {
                            Text("Communicators")
                                .font(.headline)
                            Text("26. What’s more unbelievable than a talking dog? A spelling bee.")
                            Text("27. What sounds like a sneeze and is made of leather? A shoe.")
                            Text("28. Why do melons have weddings? Because they cantaloupe.")
                            Text("29. Did you hear about the walnut and cashew that threw a party? It was nuts.")
                            Text("30. What do you call a priest that becomes a lawyer? A father-in-law.")
                        }
                        Group {
                            Text("Navigation")
                                .font(.headline)
                            Text("31. Why did the frog take the bus to work? His car got toad.")
                            Text("32. What do you call a factory that sells good products? A satisfactory.")
                            Text("33. Justice is a dish best served cold. If it were served warm, it would be just-water.")
                            Text("34. What did the fried rice say to the shrimp? Don’t wok away from me.")
                            Text("35. Did you hear about the super-hero with a lisp that always worked out? He’s Thor.")
                        }
                        Group {
                            Text("Oxygen")
                                .font(.headline)
                            Text("36. What do you call someone who gets mad when they don’t have any bread? Lack-toast intolerant.")
                            Text("37. How do you get a squirrel down from the tree? Pull down your pants and show him your nuts.")
                            Text("38. What do you call ghost poop? Boo boo.")
                            Text("39. Did you hear about Mr. Cup? Yeah, his wife left him. Now, he’s a solo cup.")
                            Text("40. Why didn’t the boat dock? Too much pierrrr pressure.")
                        }
                        Group {
                            Text("Cafeteria")
                                .font(.headline)
                            Text("41. What do you call a pile of cats? A meown-tain.")
                            Text("42. How does a train eat? It goes chew chew.")
                            Text("43. What do you call a bee that can’t make up its mind? A maybe.")
                            Text("44. What did the ocean say to the beach? Nothing, it just waved.")
                            Text("45. Why are frogs so happy? Because they eat whatever bugs them.")
                        }
                        Group {
                            Text("Admin")
                                .font(.headline)
                            Text("46. Why do seagulls fly over the ocean? Because if they flew over the bay, they’d be bagels.")
                            Text("47. Why don't eggs tell jokes? They'd crack each other up.")
                            Text("48. What’s orange and sounds like a parrot? A carrot.")
                            Text("49. What do you call a man with a rubber toe? Roberto.")
                            Text("50. Why did Waldo go to therapy? To find himself.")
                        }
                    }
                    .padding()
                }

                .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview {
    ImmersiveSpacePanelPreviewWrapper()
}

// Wrapper to provide the binding for the preview
struct ImmersiveSpacePanelPreviewWrapper: View {
    @State private var showImmersiveSpace = false
    @State private var isHandlingImmersiveSpace = false

    var body: some View {
        ImmersiveSpacePanel(showImmersiveSpace: $showImmersiveSpace, isHandlingImmersiveSpace: $isHandlingImmersiveSpace)
    }
}
