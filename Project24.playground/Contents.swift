import UIKit

var str = "Hello, playground"
let name = "Taylor"

for letter in name {
    print("Give me a \(letter)!")
}


extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}
