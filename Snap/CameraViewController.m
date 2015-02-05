//
//  CameraViewController.m
//  Snap
//
//  Created by Yi-Chin Sun on 2/3/15.
//  Copyright (c) 2015 Yi-Chin Sun. All rights reserved.
//

#import "CameraViewController.h"
#import <Parse/Parse.h>
#import "Photo.h"

@interface CameraViewController ()

@property UITextField *captionTextField;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)postPictureButtonPressed {
    Photo *photo;
    photo.caption = self.captionTextField.text;
    
//    photo[@"user"] = currentUser;
    
}

- (void)convertImageToPFFile {
    
    UIImage *image =///
    UIImageView *imageView = image;
    NSData *imageData = UIImagePNGRepresentation(imageView.image);
    
    [file saveInBackground];
    
    
    
    
//    PFFile *theImage = [object objectForKey:@"image"];
//    NSData *imageData = [theImage getData];
//    UIImage *image = [UIImage imageWithData:imageData];
//    UIImageView *imageCell = (UIImageView *)[cell viewWithTag:105];
//    imageCell.image =image;
}

@end
