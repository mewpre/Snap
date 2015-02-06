//
//  UploadDetailViewController.h
//  Snap
//
//  Created by Yi-Chin Sun on 2/3/15.
//  Copyright (c) 2015 Yi-Chin Sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UploadDelegate <NSObject>

- (void)dismissUploadViewController;

@end

@interface UploadDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property UIImage *image;

@property (nonatomic, weak) id<UploadDelegate> delegate;

@end
