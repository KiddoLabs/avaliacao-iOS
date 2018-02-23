//
//  ApiManager.h
//  KiddoTeste
//
//  Created by Aloisio Mello on 20/02/18.
//  Copyright © 2018 Aloisio Mello. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApiServices.h"

#define kWebserviceRootEndpoint @"https://api.themoviedb.org/3/movie/"
#define klistMovieApi @"popular?language=pt-BR&page=%ld"
#define kTheMovieDatabaseApiKey @"&api_key=7fd33e7b9f9a6264286c118a25ac483f"

@interface ApiManager : NSObject

+(void)getMoviesFromPage:(NSInteger)page withCallback:(void (^) (id successCallback, id faillureCallback))handler;

@end
