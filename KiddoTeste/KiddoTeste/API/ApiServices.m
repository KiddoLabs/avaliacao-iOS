//
//  ApiServices.m
//  KiddoTeste
//
//  Created by Aloisio Mello on 20/02/18.
//  Copyright © 2018 Aloisio Mello. All rights reserved.
//

#import "ApiServices.h"

@implementation ApiServices

+(void)getRequestWithEndpoint:(NSURL*)endpoint withParameter:(id)parameter withCallback : (void (^) (id successCallback, id faillureCallback))handler{
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]!=NotReachable){
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setTimeoutInterval:20.0f];
        
        NSString * url = [endpoint absoluteString];
        
        [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            NSLog(@"Processando...");
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary * dictResponse = (NSDictionary*)responseObject;
            handler([dictResponse objectForKey:@"results"],nil);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSError * parseError;
            NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
            
            if([errorData isKindOfClass:[NSData class]]){
                NSArray *arrError = [NSJSONSerialization JSONObjectWithData:errorData options:0 error:&parseError];
                
                NSDictionary * dict;
                if ([arrError isKindOfClass:[NSDictionary class]]) {
                    dict = (NSDictionary*)arrError;
                }else{
                    dict = (NSDictionary*)[arrError firstObject];
                }
                NSString * msg = [dict objectForKey:@"message"];
                
                handler(nil, msg);
            }else{
                handler(nil,@"Erro desconhecido");
            }
        }];
    }else{
        handler(nil,@"Sem conexão com a internet, por favor verifique sua conexão e tente novamente.");
    }
}


@end
