//
//  GifDetailViewController.h
//  GiphyApp
//
//  Created by Aliaksei Piatyha on 8/24/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GifDetailViewModel;

@interface GifDetailViewController : UIViewController

- (instancetype)initWithViewModel:(GifDetailViewModel *)viewModel;

@end
