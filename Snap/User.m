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


+ (User *)currentUser
{
    User *currentUser = (User *)[PFUser currentUser];
    if (currentUser)
    {
        // do stuff with the user
        return currentUser;
    }
    else
    {
        // show the signup or login screen
        return nil;
    }
}


+(void)loginWithUsername:(NSString *)username AndPassword:(NSString *)password WithCompletionBlock:(void(^)(NSError *error))complete
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

+ (void)signUpWithUsername:(NSString *)username Password:(NSString *)password AndEmail:(NSString *)email AndCompletion:(void(^)(NSError *error))complete
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








+ (void)load
{
    [self registerSubclass];
}

+ (NSString *)parseClassName
{
    return @"User";
}

@end
