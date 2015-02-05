//
//  User.h
//  Snap
//
//  Created by Chris Giersch on 2/3/15.
//  Copyright (c) 2015 Yi-Chin Sun. All rights reserved.
//

#import <Parse/Parse.h>

@interface User : PFUser<PFSubclassing>

//@property (retain) NSString *objectID;
//@property (retain) NSString *username;
//@property (retain) NSString *password;
@property (retain) UIImage *profileImage;
//@property (retain) NSDate *timeStamp;

@property (retain) PFRelation *followers;
@property (retain) PFRelation *usersFollowing;
@property (retain) PFRelation *photos;
@property (retain) PFRelation *comments;
@property (retain) PFRelation *likes;

+ (NSString *)parseClassName;

+ (void)signUpWithUsername:(NSString *)username Password:(NSString *)password AndEmail:(NSString *)email AndCompletion:(void(^)(NSError *error))complete;
+(void)loginWithUsername:(NSString *)username AndPassword:(NSString *)password WithCompletionBlock:(void(^)(NSError *error))complete;


@end
