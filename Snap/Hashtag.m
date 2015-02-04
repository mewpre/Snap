//
//  Hashtag.m
//  Snap
//
//  Created by Chris Giersch on 2/3/15.
//  Copyright (c) 2015 Yi-Chin Sun. All rights reserved.
//

#import "Hashtag.h"

@implementation Hashtag

@dynamic objectID;
@dynamic text;
@dynamic createdAt;
@dynamic updatedAt;

+ (void)load
{
    [self registerSubclass];
}

+ (NSString *)parseClassName
{
    return @"Hashtag";
}

@end
