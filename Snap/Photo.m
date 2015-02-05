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


- (void)savePhoto:(Photo *)photo withUser:(User *)user withCompletion:(void(^)(NSError *error))complete
{
    [photo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
     {
         PFRelation *relation = [user relationForKey:@"photos"];
         // Add to user's photos (photo relation)
         [relation addObject:photo];
         [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
          {
              if (error)
              {
                  NSLog(@"%@", error);
              }
              complete(error);
          }];
         if (error)
         {
             NSLog(@"%@", error);
         }
         complete(error);
     }];
}

- (void)savePhotoWithImage:(UIImage *)image withUser:(User *)user {
    
//    Photo *currentPhoto = [Photo new];
    NSData *imageData = UIImagePNGRepresentation(image);
    PFFile *file = [PFFile fileWithData:imageData];
    self.imageFile = file;
    [self saveInBackground];
    [user addObject:self forKey:@"photos"];
    [user saveInBackground];

//    [User.currentUser savePhotoWithData:mageData];
}


+ (void)load
{
    [self registerSubclass];
}

+ (NSString *)parseClassName
{
    return @"Photo";
}

+ (NSArray *)retrievePhotosOfUser:(NSString *)searchTerm
{
    PFQuery *query = [PFQuery queryWithClassName:@"Photo"];
    [query whereKey:@"user" containsString:searchTerm];
    [query orderByDescending:@"createdAt"];
    return [query findObjects];
}

@end
