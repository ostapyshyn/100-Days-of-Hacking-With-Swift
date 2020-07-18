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


let string = "This is a test string"
let attributes: [NSAttributedString.Key: Any] = [
    .foregroundColor: UIColor.white,
    .backgroundColor: UIColor.red,
    .font: UIFont.boldSystemFont(ofSize: 36)
]

//let attributedString = NSAttributedString(string: string, attributes: attributes)


let attributedString = NSMutableAttributedString(string: string)
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 8), range: NSRange(location: 0, length: 4))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: 5, length: 2))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 24), range: NSRange(location: 8, length: 1))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 32), range: NSRange(location: 10, length: 4))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 40), range: NSRange(location: 15, length: 6))


extension String {

    /// Returns the string, ensuring that it has the given prefix
    func withPrefix(_ prefix: String) -> String {
        guard !self.hasPrefix(prefix) else { return self }
        return prefix + self
    }
}

print("pet".withPrefix("car"))    // prints "carpet"
print("carpet".withPrefix("car")) // prints "carpet"


extension String {

    /// Returns true if the whole string is a number
    var isNumeric: Bool {
        return Double(self) != nil
    }

    /// Returns true if any character in the string is a number
    var hasNumeric: Bool {
        return self.contains { Double("\($0)") != nil }
    }
}

print("1.74".isNumeric)         // prints true

print("OneTwo3Four".isNumeric)  // prints false
print("OneTwo3Four".hasNumeric) // prints true


extension String {

    /// Returns an array of strings separated by new lines
    func lines() -> [String] {
        return self.components(separatedBy: .newlines)
    }
}

print("this\nis\na\ntest".lines())
// prints ["this", "is", "a", "test"]
