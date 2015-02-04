//
//  User.m
//  Snap
//
//  Created by Chris Giersch on 2/3/15.
//  Copyright (c) 2015 Yi-Chin Sun. All rights reserved.
//

#import "User.h"

@implementation User

//@dynamic objectID;
@dynamic username;
//@dynamic password;
@dynamic profileImage;
//@dynamic timeStamp;

@dynamic followers;
@dynamic usersFollowing;
@dynamic photos;
@dynamic comments;
@dynamic likes;

+ (void)load
{
    [self registerSubclass];
}

+ (NSString *)parseClassName
{
    return @"User";
}

//- (void) setLikes:(PFRelation *)likes
//{
//    _likes = likes;
//}
//
//
//- (PFRelation *) likes
//{
//    if(_likes== nil)
//    {
//        _likes = [self relationforKey:@"likes"];
//    }
//    return _likes;
//}

@end
