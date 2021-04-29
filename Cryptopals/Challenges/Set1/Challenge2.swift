//
//  Challenge2.swift
//  Cryptopals
//
//  Created by Chris Downie on 4/28/21.
//

import Foundation
import CryptoTools

enum ChallengeTwo {
    static func run() {
        let key = DataDisplay.data(forHexString: "686974207468652062756c6c277320657965")!
        let cipher = FixedXorCipher(key: key)
        
        let input = DataDisplay.data(forHexString: "1c0111001f010100061a024b53535009181c")!
        let expected = DataDisplay.data(forHexString: "746865206b696420646f6e277420706c6179")!
        let output = cipher.decrypt(data: input)
        
        if output == expected {
            print("🎉 Challenge Two Success! 🎉")
        } else {
            print("❌ Decrypted output did not match. ❌")
        }
    }
}
