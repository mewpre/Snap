//
//  Photo.m
//  Snap
//
//  Created by Chris Giersch on 2/3/15.
//  Copyright (c) 2015 Yi-Chin Sun. All rights reserved.
//

#import "Photo.h"

@implementation Photo

//@dynamic objectID;
//@dynamic locationStamp;
@dynamic caption;
//@dynamic createdAt;
//@dynamic updatedAt;
//@dynamic timeStamp;
@dynamic imageFile;

@dynamic user;
@dynamic usersWhoLike;
@dynamic comments;
@dynamic hashtags;

+ (void)load
{
    [self registerSubclass];
}

+ (NSString *)parseClassName
{
    return @"Photo";
}

@end
