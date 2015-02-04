//
//  Comment.h
//  Snap
//
//  Created by Chris Giersch on 2/3/15.
//  Copyright (c) 2015 Yi-Chin Sun. All rights reserved.
//

#import <Parse/Parse.h>

@interface Comment : PFObject<PFSubclassing>

//@property (retain) NSString *objectID;
@property (retain) NSString *text;
//@property (retain) PFObject *createdAt; // Right format????   ***
@property (retain) UIImage *profileImage;
//@property (retain) NSDate *timeStamp;

@property (retain) PFRelation *user;
@property (retain) PFRelation *photo;

+ (NSString *)parseClassName;

@end
