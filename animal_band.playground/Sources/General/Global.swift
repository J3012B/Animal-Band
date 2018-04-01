import Foundation


var currentSong = "under_the_sea"
var audienceApplauses = true

public func uglify(songName: String) -> String {
    let lowercase = songName.lowercased()
    let withUnderScore = lowercase.replacingOccurrences(of: " ", with: "_")
    let withExtension = withUnderScore
    
    return withExtension
}

public func prettify(songName: String) -> String {
    let uglySongName = songName.split(separator: ".")[0]
    let songLowercase = uglySongName.replacingOccurrences(of: "_", with: " ")
    
    return songLowercase.capitalized
}



// f.i. 4 fits 3 times into 13
public func fits(number num1: Int, into num2: Int) -> Int {
    var currentNum = abs(num1)
    var counter = 0
    
    while currentNum <= abs(num2) {
        currentNum += abs(num1)
        counter += 1
    }
    
    return counter
}
