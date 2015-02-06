//
//  DragonSlayer.swift
//  dragonfashion
//
//  Created by Chris Giersch on 2/6/15.
//  Copyright (c) 2015 Dave Krawczyk. All rights reserved.
//

import Foundation

@objc class DragonSlayer : NSObject
{
    var name = String()
    var strength = Int()
    var slayedDragon = [Dragon]()

    func slayedDragon (dragon: Dragon)
    {
        slayedDragon.append(dragon)
    }
}