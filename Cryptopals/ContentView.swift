//
//  ContentView.swift
//  Cryptopals
//
//  Created by Chris Downie on 4/25/21.
//

import SwiftUI

struct ContentView: View {
    let shouldRunAllChallenges = false

    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear(perform: runCurrentChallenge)
    }

    func runCurrentChallenge() {
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] == nil {
            let types = shouldRunAllChallenges ? Challenges.all : [Challenges.current]
            let runner = ChallengeRunner(challengeTypes: types)
            runner.run()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
