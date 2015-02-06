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
@property (retain) PFFile *profileImage;
//@property (retain) NSDate *timeStamp;

@property (retain) PFRelation *followers;
@property (retain) PFRelation *usersFollowing;
@property (retain) PFRelation *photos;
@property (retain) PFRelation *comments;
@property (retain) PFRelation *likes;

+ (NSString *)parseClassName;
+ (void)retrieveUsersFollowingWithCompletion:(void(^)(NSArray *usersFollowingArray))Complete;
+ (void)retrieveFollowersWithCompletion:(void(^)(NSArray *followersArray))Complete;
+ (void)retrieveRecent48HourPhotosFromUser:(PFUser *)user withCompletion:(void(^)(NSArray *photosArray))Complete;
+ (void)retrieveLikedPhotosWithCompletion:(void(^)(NSArray *likedPhotosArray))Complete;
+ (void)signUpWithUsername:(NSString *)username password:(NSString *)password email:(NSString *)email withCompletion:(void(^)(NSError *error))complete;
+ (void)loginWithUsername:(NSString *)username andPassword:(NSString *)password withCompletionBlock:(void(^)(NSError *error))complete;
- (UIImage *)getProfileImage;

+ (void)retrieveMostRecentPhotos:(void(^)(NSArray *photosArray))complete;

@end
