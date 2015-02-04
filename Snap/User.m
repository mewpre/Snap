//
//  User.m
//  Snap
//
//  Created by Chris Giersch on 2/3/15.
//  Copyright (c) 2015 Yi-Chin Sun. All rights reserved.
//

#import "User.h"

@implementation User

@dynamic username;
@dynamic password;
@dynamic profileImage;

+ (void)load
{
    [self registerSubclass];
}

+ (NSString *)parseClassName
{
    return @"Armor";
}

@end
