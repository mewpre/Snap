//
//  Hashtag.h
//  Snap
//
//  Created by Chris Giersch on 2/3/15.
//  Copyright (c) 2015 Yi-Chin Sun. All rights reserved.
//

#import <Parse/Parse.h>

@interface Hashtag : PFObject

@property (retain) NSString *objectID;
@property (retain) NSString *text;
//@property (retain) NSDate *createdAt; // Correct format???    ***
//@property (retain) NSDate *updatedAt; // Correct format???    ***
@property (retain) NSDate *timeStamp;

@property (retain) PFRelation *photos;

+ (NSString *)parseClassName;

@end
