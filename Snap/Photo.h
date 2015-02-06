//
//  Photo.h
//  Snap
//
//  Created by Chris Giersch on 2/3/15.
//  Copyright (c) 2015 Yi-Chin Sun. All rights reserved.
//

#import <Parse/Parse.h>
#import "User.h"

@interface Photo : PFObject

//@property (retain) NSString *objectID;
//@property (retain) NSString *locationStamp;  // WHAT FORMAT???
@property (retain) NSString *caption;
@property (retain) PFFile *imageFile;
//@property (retain) NSDate *createdAt;
//@property (retain) NSDate *updatedAt;
//@property (retain) NSDate *timeStamp;

@property (retain) PFRelation *user;
@property (retain) PFRelation *usersWhoLike;
@property (retain) PFRelation *comments;
@property (retain) PFRelation *hashtags;

+ (NSString *)parseClassName;

- (void)savePhoto:(Photo *)photo withUser:(User *)user withCompletion:(void(^)(NSError *error))complete;
- (void)savePhotoWithImage:(UIImage *)image withUser:(User *)user;
- (UIImage *)getUIImage;

@end
