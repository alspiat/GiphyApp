//
//  GifListViewController.h
//  GiphyApp
//
//  Created by Aliaksei Piatyha on 8/24/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GifListViewModel;
@protocol ControllerViewModel;

@interface GifListViewController : UIViewController

@property (readonly, weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (readonly, nonatomic, strong) id<ControllerViewModel> viewModel;
@property (readonly, weak, nonatomic) IBOutlet UITextField *searchTextField;

- (instancetype)initWithViewModel:(id<ControllerViewModel>)viewModel;

@end
