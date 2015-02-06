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
//@dynamic username;
//@dynamic password;
@dynamic profileImage;
//@dynamic timeStamp;

@dynamic followers;
@dynamic usersFollowing;
@dynamic photos;
@dynamic comments;
@dynamic likes;

+ (void)retrieveMostRecentPhotos:(void(^)(NSArray *photosArray))complete
{
    PFRelation *relation = [[PFUser currentUser] relationForKey:@"usersFollowing"];

    [relation.query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        }
        NSLog(@"did this %@", objects);
    }];
}

+ (void)retrieveUsersFollowingWithCompletion:(void(^)(NSArray *usersFollowingArray))Complete
{
    PFRelation *relation = [[PFUser currentUser] relationForKey:@"followers"];
    [relation.query addAscendingOrder:@"username"];
    [relation.query findObjectsInBackgroundWithBlock:^(NSArray *usersFollowing, NSError *error)
     {
         if (!error)
         {
             Complete(usersFollowing);
         }
         else
         {
             NSLog(@"%@", error);
         }
     }];
}

+ (void)retrieveFollowersWithCompletion:(void(^)(NSArray *followersArray))Complete
{
    PFRelation *relation = [[PFUser currentUser] relationForKey:@"followers"];
    [relation.query addAscendingOrder:@"username"];
    [relation.query findObjectsInBackgroundWithBlock:^(NSArray *followers, NSError *error)
     {
         if (!error)
         {
             Complete(followers);
         }
         else
         {
             NSLog(@"%@", error);
         }
     }];
}

+ (void)retrieveLikedPhotosWithCompletion:(void(^)(NSArray *likedPhotosArray))Complete
{
    PFRelation *relation = [[PFUser user]relationForKey:@"likes"];
    [relation.query addDescendingOrder:@"createdAt"];
    [relation.query findObjectsInBackgroundWithBlock:^(NSArray *photosArray, NSError *error)
     {
         if (!error)
         {
             Complete(photosArray);
         }
         else
         {
             NSLog(@"%@", error);
         }
     }];
}

+ (void)retrieveRecent48HourPhotosFromUser:(PFUser *)user withCompletion:(void(^)(NSArray *photosArray))Complete
{
    PFRelation *relation = [user relationForKey:@"photos"];
    [relation.query addAscendingOrder:@"createdAt"];

    // create date 48 hours ago
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:-172800];
    [relation.query whereKey:@"createdAt" greaterThan:date];
//    [relation.query whereKey:@"user" equalTo:user];

    [relation.query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if (!error)
         {
             Complete(objects);
         }
         else
         {
             NSLog(@"%@", error);
         }
     }];
}


+ (void)loginWithUsername:(NSString *)username andPassword:(NSString *)password withCompletionBlock:(void(^)(NSError *error))complete
{
    [PFUser logInWithUsernameInBackground:username password:password
                                    block:^(PFUser *user, NSError *error)
     {
         if (user)
         {
             // Do stuff after successful login.
             NSLog(@"%@ logged in", user.username);
         }
         else
         {
             // The login failed. Check error to see why.
             NSLog(@"%@", error);
         }
         complete(error);
     }];
}

+ (void)signUpWithUsername:(NSString *)username password:(NSString *)password email:(NSString *)email withCompletion:(void(^)(NSError *error))complete
{
    // Code to test Parse connection.
    User *user = (User *)[PFUser user];
    user.username = username;
    user.password = password;
    user.email = email;

    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error)
        {
            // Hooray! Let them use the app now.
            NSLog(@"User created");
        }
        else
        {
            NSString *errorString = [error userInfo][@"error"];
            // Show the errorString somewhere and let the user try again.
            NSLog(@"%@", errorString);
        }
        complete(error);
    }];
}

- (void)retrieveMostRecentPhotos:(void(^)(NSArray *photosArray))complete
{
    PFQuery *query = [self.usersFollowing query];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSLog(@"did this %@", objects);
    }];
    
    PFQuery *photosQuery = [PFQuery queryWithClassName:@"Photo"];
    [photosQuery whereKey:@"user" matchesKey:@"username" inQuery:query];
    
    [photosQuery addDescendingOrder:@"createdAt"];
    
    [photosQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        
        complete(objects);
    }];
    
    
}


+ (void)load
{
    [self registerSubclass];
}

+ (NSString *)parseClassName
{
    return @"User";
}

- (UIImage *)getProfileImage
{
    NSData *imageData = [self.profileImage getData];
    return [UIImage imageWithData:imageData];
}

@end
