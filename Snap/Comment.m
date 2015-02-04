//
//  Comment.m
//  Snap
//
//  Created by Chris Giersch on 2/3/15.
//  Copyright (c) 2015 Yi-Chin Sun. All rights reserved.
//

#import "Comment.h"

@implementation Comment

//@dynamic objectID;
@dynamic text;
//@dynamic createdAt;
@dynamic profileImage;
//@dynamic timeStamp;

@dynamic user;
@dynamic photo;

+ (void)load
{
    [self registerSubclass];
}

+ (NSString *)parseClassName
{
    return @"Comment";
}

@end
