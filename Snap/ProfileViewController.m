//
//  ProfileViewController.m
//  Snap
//
//  Created by Yi-Chin Sun on 2/3/15.
//  Copyright (c) 2015 Yi-Chin Sun. All rights reserved.
//

#import "ProfileViewController.h"
#import "ImageCollectionViewCell.h"
#import "Photo.h"
#import "User.h"

@interface ProfileViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>


@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *followersLabel;
@property (strong, nonatomic) IBOutlet UILabel *following;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSArray *photosArray;
@property User *currentUser;

@end

@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.currentUser = [User currentUser];
//    self.profileImageView.image = [self.currentUser getProfileImage];
    self.usernameLabel.text = self.currentUser.username;
    
    [User retrieveRecent48HourPhotosFromUser:self.currentUser withCompletion:^(NSArray *photosArray)
     {
         self.photosArray = photosArray;
     }];


}

#pragma mark - Collection View Delegates

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photosArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    Photo *photo = [self.photosArray objectAtIndex:indexPath.row];
    cell.imageView.image = [photo getUIImage];
    return cell;
}

@end
