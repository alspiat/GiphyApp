//
//  GifManagedObjectEntity+CoreDataProperties.m
//  GiphyApp
//
//  Created by Dmitriy Tarelkin on 29/8/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//
//

#import "GifManagedObjectEntity+CoreDataProperties.h"

@implementation GifManagedObjectEntity (CoreDataProperties)

+ (NSFetchRequest<GifManagedObjectEntity *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"GifManagedObjectEntity"];
}

@dynamic id;
@dynamic title;
@dynamic username;
@dynamic rating;
@dynamic publishingDate;
@dynamic trendingDate;
@dynamic previewImage;
@dynamic originalImage;

@end
