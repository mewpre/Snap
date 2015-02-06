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


//+ (void)savePhoto:(Photo *)photo withUser:(User *)user withCompletion:(void(^)(NSError *error))complete
//{
//    [photo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
//     {
//         PFRelation *relation = [user relationForKey:@"photos"];
//         // Add to user's photos (photo relation)
//         [relation addObject:photo];
//         [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
//          {
//              if (error)
//              {
//                  NSLog(@"%@", error);
//              }
//              complete(error);
//          }];
//         if (error)
//         {
//             NSLog(@"%@", error);
//         }
//         complete(error);
//     }];
//}

- (void)savePhotoWithImage:(UIImage *)image caption:(NSString *)caption withUser:(User *)user withCompletion:(void(^)(NSError *error))complete
{
    NSData *imageData = UIImagePNGRepresentation(image);
    PFFile *file = [PFFile fileWithData:imageData];
    self.imageFile = file;
    self.caption = caption;
    [self saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {

//        Photo *photo = self;
        PFRelation *relation = [[PFUser currentUser] relationForKey:@"photos"];
        [relation addObject:self];
        [[PFUser currentUser] saveEventually];
    }];
}

+ (void)retrieveCommentsFromPhoto:(Photo *)photo withCompletion:(void(^)(NSArray *photosArray))Complete
{
    PFRelation *relation = [photo relationForKey:@"comments"];
    [relation.query addAscendingOrder:@"timeStamp"];

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

- (UIImage *)getUIImage
{
    NSData *imageData = [self.imageFile getData];
    return [UIImage imageWithData:imageData];
}

- (void)getUIImageWithCompletion:(void(^)(UIImage *image))Complete
{
    [self.imageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error)
     {
         UIImage *image = [UIImage imageWithData:imageData];
         Complete(image);
     }];
}

+ (void)load
{
    [self registerSubclass];
}

+ (NSString *)parseClassName
{
    return @"Photo";
}

@end
