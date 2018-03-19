import Foundation

public struct Note {
    var pitch: String
    var octave: Int
    var time: Int
    
    public init(pitch: String, octave: Int, time: Int) {
        self.pitch = pitch
        self.octave = octave
        self.time = time
    }
}

