import Foundation
import PlaygroundSupport

public struct Song {
    public var tempo = 100
    public var beats = 4
    public var rythm = 4
    public var instruments = [String: [Note]]()
    public var length = 0
    
    public init() {
        self.tempo = 100
        self.beats = 4
        self.rythm = 4
        self.instruments = [String : [Note]]()
    }
    
    public init(filePath: String) {
        if let path = Bundle.main.path(forResource: filePath, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                //print("Song.init >> will try to serialize json")
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                //print("Song.init >> did try to serialize json")
                if  let song = jsonResult as? Dictionary<String, AnyObject>,
                    let info = song["info"] as? [String: Int],
                    let instruments = song["instruments"] as? [String : [[String: Any]]]  {
                    
                    self.tempo = info["tempo"]!
                    self.beats = info["beats"]!
                    self.rythm = info["rythm"]!
                    
                    //print("Count of instruments is \(instruments.count)")
                    
                    for (instrument, notes) in instruments {
                        //print(instrument + " plays the following notes:")
                        
                        if notes.count == 0 {
                            self.instruments[instrument] = [Note]()
                        }
                        
                        for note in notes {
                            let pitch = note["pitch"] as! String
                            let octave = note["octave"] as! Int
                            let time = note["time"] as! Int
                            
                            let newNote = Note(pitch: pitch, octave: octave, time: time)
                            
                            //print("Add new note to '\(instrument)': \(newNote.pitch!)\(newNote.octave!) at \(newNote.time!)")
                            
                            if self.instruments[instrument] == nil {
                                self.instruments[instrument] = [Note]()
                            }
                            self.instruments[instrument]! += [newNote]
                            
                            if time > length {
                                self.length = time
                            }
                        }
                    }
                    
                    self.length += 8
                    
                } else {
                    print("Song.init >> Could not load song from json")
                    self.tempo = 100
                    self.beats = 4
                    self.rythm = 4
                    self.instruments = [String : [Note]]()
                    self.length = 0
                }
            } catch {
                print("Sing.init >> Could not prepare song instructions for '\(filePath)'")
                self.tempo = 100
                self.beats = 4
                self.rythm = 4
                self.instruments = [String : [Note]]()
                self.length = 0
            }
        } else if false {
            
        } else {
            print("Song.init >> Couldn't find file path for song")
        }
    }
    

    
    
    
    private func getStringifiedSong() -> String {
        var instrumentsJsonString = "{"
        
        for (instrument, notes) in self.instruments {
            var instrumentString =
            """
            "\(instrument)": [
            """
            
            for note in notes {
                instrumentString +=
                """
                {
                    "pitch": \(note.pitch!),
                    "octave": \(note.octave!),
                    "time": \(note.time!)
                },
                """
            }
            if notes.count > 0 {
                instrumentString = String(instrumentString.dropLast())
            }
            instrumentString += "],"
            
            instrumentsJsonString += instrumentString
        }
        instrumentsJsonString = String(instrumentsJsonString.dropLast())
        
        instrumentsJsonString += "}"
        
        
        let wholeString =
"""
{
     "info": {
         "tempo": \(self.tempo),
         "beats": \(self.beats),
         "rythm": \(self.rythm)
     },
     "instruments": \(instrumentsJsonString)
}
"""
        
        
        return wholeString
    }
    
    public func save(to fileName: String) {
        // 1. file existiert noch nicht
        //  b. file gibt es noch nicht -> speichern
        // 2. file existiert
        
        let defaultSongNames = loadFileNamesOfDefaultSongs()
        
        // check if song name already is given in the defaults song files (if yes -> return)
        if defaultSongNames.contains(fileName) {
            print("You can't save changes in '\(prettify(songName: fileName))', because it's one of the default song files.")
            return
        }
        
        // stringify song
        let fileContent = getStringifiedSong()
        
        print("will try to save: \n\(fileContent)")
        
        let fileName = playgroundSharedDataDirectory.appendingPathComponent(fileName + ".json")
        
        do {
            try fileContent.write(to: fileName, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("Song.save >> could not save song file with name '\(fileName).json'")
        }
        
    }
    
    private func loadFileNamesOfDefaultSongs() -> [String] {
        let defaultSongNamePaths = Bundle.main.paths(forResourcesOfType: "json", inDirectory: "songs/")
        var defaultSongNames = [String]()
        
        
        for defaultSongPath in defaultSongNamePaths {
            let songPathArray = defaultSongPath.split(separator: "/") // array with path components
            let withExtension = String(songPathArray[songPathArray.count - 1]) // only song file name (with extension)
            let defaultSongName = String(withExtension.split(separator: ".")[0])
            
            defaultSongNames.append(defaultSongName)
        }
        
        return defaultSongNames
    }
    
}



/*
    SAMPLE JSON
 
 
 

 */

