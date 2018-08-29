//
//  GifListViewController.m
//  GiphyApp
//
//  Created by Aliaksei Piatyha on 8/24/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

#import "GifListViewController.h"
#import "GifCollectionViewCell.h"
#import "GiphyApp-Swift.h"

//importing
#import "GifDetailViewController.h"

@interface GifListViewController () <UICollectionViewDataSource, UICollectionViewDelegate, GifCollectionViewLayoutDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(nonatomic, strong) GifListViewModel *viewModel;


@end

@implementation GifListViewController

- (instancetype)initWithViewModel:(GifListViewModel *)viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    GifCollectionViewLayout *layout = (GifCollectionViewLayout *)self.collectionView.collectionViewLayout;
    layout.delegate = self;
    
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

// MARK: - Collection View DataSource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewModel.numberOfRows;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GifCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:gifCellIdentifier forIndexPath:indexPath];
    [cell setup:[self.viewModel viewModelForCellAt:indexPath.row]];
    
    [self.viewModel loadDataIfNeededFromIndex:indexPath.row];
    
    return cell;
}

// MARK: - GifCollectionViewLayout Delegate methods

- (CGFloat)collectionView:(UICollectionView *)collectionView heightForContentAtIndexPath:(NSIndexPath *)indexPath {
    GifCollectionViewLayout *layout = (GifCollectionViewLayout *)self.collectionView.collectionViewLayout;
    CGSize contentSize = [self.viewModel contentSizeAt:indexPath.row];
    return contentSize.height * layout.columnWidth / contentSize.width;
}





/////////////////////////////////\\\\\Dimas\\\\\\\\\\///////////////////////////////////

// MARK: GifCollectionViewDelegeta
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GifCollectionViewCell * cell = (GifCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    //points
    CGPoint newPoint =
    [collectionView convertPoint: cell.center toView:self.view];
   
    //second controller
    Navigation* nav = [[Navigation alloc] init];
    [nav showGifDetailWith:cell.viewModel.gifEntity and:newPoint presentingController:self];
   
}


@end
