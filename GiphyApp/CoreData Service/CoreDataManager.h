//
//  CoreDataManager.h
//  GiphyApp
//
//  Created by Dmitriy Tarelkin on 29/8/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GifEntity;

@protocol CoreDataManager
- (NSArray<GifEntity *> *)getAllItems;
- (GifEntity *)getItemWithID:(NSString *)itemID;
- (void)addItem:(GifEntity *)item;
- (void)deleteItem:(GifEntity *)item;
- (BOOL)itemExistsWithID:(NSString *)itemID;
@end


@interface CoreDataManager : NSObject<CoreDataManager>

@end
