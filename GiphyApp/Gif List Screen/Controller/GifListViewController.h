//
//  GifListViewController.h
//  GiphyApp
//
//  Created by Aliaksei Piatyha on 8/24/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GifTrendingViewModel;
@protocol GifListViewModel;

@interface GifListViewController : UIViewController

@property (readonly, weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (readonly, nonatomic, strong) id<GifListViewModel> viewModel;
@property (readonly, weak, nonatomic) IBOutlet UITextField *searchTextField;

- (instancetype)initWithViewModel:(id<GifListViewModel>)viewModel;

@end
