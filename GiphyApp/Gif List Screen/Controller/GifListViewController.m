//
//  GifListViewController.m
//  GiphyApp
//
//  Created by Aliaksei Piatyha on 8/24/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

#import "GifListViewController.h"
#import "GifListViewController+CollectionView.h"
#import "GifListViewController+SearchTextField.h"
#import "GifCollectionViewCell.h"

@interface GifListViewController ()

@property (readwrite, weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (readwrite, weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (readwrite, nonatomic, strong) id<ControllerViewModel> viewModel;


@end

@implementation GifListViewController

- (instancetype)initWithViewModel:(id<ControllerViewModel>)viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.viewModel.title;

    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    GifCollectionViewLayout *layout = (GifCollectionViewLayout *)self.collectionView.collectionViewLayout;
    layout.delegate = self;
    
    UIView *paddingView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 10, self.searchTextField.frame.size.height)];
    self.searchTextField.leftView = paddingView;
    self.searchTextField.leftViewMode = UITextFieldViewModeAlways;
    self.searchTextField.delegate = self;

    [self.collectionView registerNib:[UINib nibWithNibName:gifCellNibName bundle:NSBundle.mainBundle] forCellWithReuseIdentifier:gifCellIdentifier];
    
    [self bindToViewModel];
    [self.viewModel loadDataIfNeededFromIndex:0];
}

- (void)bindToViewModel {
    __weak typeof(self) weakSelf = self;
    self.viewModel.didUpdate = ^{
        [weakSelf viewModelDidUpdate];
    };
}

- (void)viewModelDidUpdate {
    [self.collectionView performBatchUpdates:^{
        for (NSInteger i = [self.collectionView numberOfItemsInSection:0]; i < self.viewModel.numberOfRows; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            [self.collectionView insertItemsAtIndexPaths:@[indexPath]];
        }
    } completion:nil];
    
//    [self.collectionView reloadData];
}

- (IBAction)searchButtonTapped:(UIButton *)sender {
    if (![self.searchTextField.text isEqualToString:@""]) {
        [Navigation.shared showGifSearchWithQuery:self.searchTextField.text];
    }
}


@end
