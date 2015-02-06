//
//  SearchViewController.m
//  Snap
//
//  Created by Yi-Chin Sun on 2/3/15.
//  Copyright (c) 2015 Yi-Chin Sun. All rights reserved.
//

#import "SearchViewController.h"
#import "ImageCollectionViewCell.h"
#import <Parse/Parse.h>
#import "User.h"
#import "Photo.h"

@interface SearchViewController () <UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) NSArray *photosArray;

@end

@implementation SearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setPhotosArray:(NSArray *)photosArray
{
    _photosArray = photosArray;
    [self.collectionView reloadData];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    Photo *photo = [self.photosArray objectAtIndex:indexPath.row];
    NSData *imageData = [photo.imageFile getData];
    cell.imageView.image = [UIImage imageWithData:imageData];
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photosArray.count;
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (self.segmentedControl.selectedSegmentIndex == 0)
    {
        //hashtag search
    }
    else
    {
        PFQuery *query = [PFQuery queryWithClassName:@"User"];
        [query whereKey:@"name" containsString:searchBar.text];
        User *user = (User*)[query getFirstObject];
        if (user)
        {
            [User retrieveRecent48HourPhotosFromUser:user withCompletion:^(NSArray *photosArray)
             {
                 self.photosArray = photosArray;
             }];
        }
    }
}

@end
