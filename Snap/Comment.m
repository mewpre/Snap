//
//  Comment.m
//  Snap
//
//  Created by Chris Giersch on 2/3/15.
//  Copyright (c) 2015 Yi-Chin Sun. All rights reserved.
//

#import "Comment.h"
#import "Photo.h"
#import "User.h"

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

- (void)saveCommentWithText:(NSString *)commentText forPhoto:(Photo *)photo withCompletion:(void(^)(NSError *error))complete
{
    self.text = commentText;
    [self saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        PFRelation *photoRelation = [photo relationForKey:@"comments"];
        [photoRelation addObject:self];
        PFRelation *userRelation = [[PFUser currentUser] relationForKey:@"comments"];
        [userRelation addObject:self];
        [photo saveEventually];
    }];
}



@end
