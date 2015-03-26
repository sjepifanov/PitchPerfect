//
//  RecordedAudio.swift
//  PitchPerfect
//
//  Created by Sergei on 23/03/15.
//  Copyright (c) 2015 Sergei. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    //Declare and initialize class parameters to pass recorded file name and path from RecordSoundsViewController to PlaySoundsViewCOntroller.
    var title: String!
    var filePathUrl: NSURL!
    
    init(title: String, filePathUrl: NSURL) {
        self.title = title
        self.filePathUrl = filePathUrl
    }
}
