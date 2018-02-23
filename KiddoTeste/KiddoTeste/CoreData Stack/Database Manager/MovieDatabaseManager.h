//
//  MovieDatabaseManager.h
//  KiddoTeste
//
//  Created by Aloisio Mello on 21/02/18.
//  Copyright © 2018 Aloisio Mello. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface MovieDatabaseManager : NSManagedObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

-(instancetype)init;
+(id)sharedManager;

@end
