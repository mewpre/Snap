//
//  SearchViewController.m
//  Snap
//
//  Created by Yi-Chin Sun on 2/3/15.
//  Copyright (c) 2015 Yi-Chin Sun. All rights reserved.
//

#import "SearchViewController.h"
#import "PhotoViewController.h"
#import "ImageCollectionViewCell.h"
#import <Parse/Parse.h>
#import "User.h"
#import "Photo.h"

@interface SearchViewController () <UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) NSArray *photosArray;
@property UIImage *image;

@end

@implementation SearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setPhotosArray:(NSArray *)photosArray
{
    _photosArray = photosArray;
    [self.collectionView reloadData];
    //Default to user search since we haven't implemented hashtags
    self.segmentedControl.selectedSegmentIndex = 1;
}


//---------------------------------------------    Show View    ----------------------------------------------
#pragma mark - Show View
- (void)showPhotoViewControllerWithPhotos:(NSArray *)array
{
    PhotoViewController *photoVC = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([PhotoViewController class])];
    photoVC.photosArray = array;
    [self.navigationController pushViewController:photoVC animated:YES];
}


//----------------------------------------------    Collection View    ----------------------------------------------
#pragma mark - Collection View
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    Photo *photo = [self.photosArray objectAtIndex:indexPath.row];
    cell.imageView.image = [photo getUIImage];
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photosArray.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Photo *photo = self.photosArray[indexPath.row];
    NSArray *array = [[NSArray alloc] initWithObjects:photo, nil];
    [self showPhotoViewControllerWithPhotos:array];
}


//------------------------------------------------    Search Bar    ----------------------------------------------
#pragma mark - Search Bar
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (self.segmentedControl.selectedSegmentIndex == 0)
    {
        //hashtag search
    }
    else
    {
        PFQuery *query = [PFUser query];
        [query whereKey:@"username" containsString:searchBar.text];
        NSArray *users = [query findObjects];
        PFUser *user = [users firstObject];
        //        User *user = (User*)[query getFirstObject];
        if (user)
        {
            [User retrieveRecent48HourPhotosFromUser:user withCompletion:^(NSArray *photosArray)
             {
                 self.photosArray = photosArray;
                 [searchBar resignFirstResponder];
             }];
        }
    }
}

@end
