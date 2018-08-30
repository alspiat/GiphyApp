//
//  GifManagedObjectEntity+CoreDataClass.h
//  GiphyApp
//
//  Created by Aliaksei Piatyha on 8/30/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "GifModel.h"

extern NSString * _Nonnull const gifEntityName;

@class GifEntity;

NS_ASSUME_NONNULL_BEGIN

@interface GifManagedObjectEntity : NSManagedObject <GifModel>

@property (nonnull, nonatomic, copy) NSString *id;
@property (nullable, nonatomic, copy) NSDate *publishingDate;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSDate *trendingDate;
@property (nullable, nonatomic, copy) NSString *username;
@property (nonnull, nonatomic, retain) id<GifImageModel> originalImage;
@property (nonnull, nonatomic, retain) id<GifImageModel> previewImage;

+ (NSFetchRequest<GifManagedObjectEntity *> *)fetchRequest;
- (GifManagedObjectEntity*)initWithItem:(GifEntity *)item context:(NSManagedObjectContext *)context;

@end

NS_ASSUME_NONNULL_END
