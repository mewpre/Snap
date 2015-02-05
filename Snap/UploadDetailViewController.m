//
//  UploadDetailViewController.m
//  Snap
//
//  Created by Yi-Chin Sun on 2/3/15.
//  Copyright (c) 2015 Yi-Chin Sun. All rights reserved.
//

#import "UploadDetailViewController.h"
#import "Photo.h"

@interface UploadDetailViewController ()

@property (strong, nonatomic) IBOutlet UITextField *captionTextField;
@property (strong, nonatomic) IBOutlet UITextField *tagUsersTextField;


@end

@implementation UploadDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.imageView.image = self.image;
}

- (IBAction)onShareButtonTapped:(id)sender
{
}

- (IBAction)onPostButtonTapped:(id)sender
{
    Photo *currentPhoto = [Photo new];
    [currentPhoto savePhotoWithImage:self.image withUser:[User currentUser]];
}

- (IBAction)onCancelButtonTapped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
