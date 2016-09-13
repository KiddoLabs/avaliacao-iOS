//
//  MovieService.h
//  GuideboxiOS
//
//  Created by Ezequiel Thomazetto on 08/09/16.
//  Copyright © 2016 Ezequiel Thomazetto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
//Models
#import "MovieList.h"
#import "MovieDetail.h"

@protocol MovieServiceDelegate

@optional
/**
 Delegate responsavel por responser ao alvo um objeto de sucesso.
 
 @param response objeto de sucesso.
 */
-(void)responseSuccess:(id)response;

/**
 Delegate responsavel por responser ao alvo um objeto de erro.
 
 @param error objeto de erro.
 */
-(void)responseError:(NSError*)error;

@end

@interface MovieService : NSObject

/**
 Este metodo inicializa o objeto de requisição.
 
 @param target Indica o alvo em que deseja retornar a resposta das requisições.
 @return Instancia do objeto de requisição.
 */
- (instancetype)initWithTarget:(id<MovieServiceDelegate>)target;

/**
 Este metodo aciona a requisição para recuperar a listagem de títulos.
 
 @param startAt Indica qual o índice do inicio da lista que deseja recuperar.
 @param size Indica o tamanho da lista que deseja recuperar.
 */
-(void)getMovieListWithStart:(NSInteger)startAt size:(NSInteger)size;

/**
 Este metodo aciona a requisição para recuperar um título específico.
 
 @param movieID Indica qual o identificador único do título que deseja recuperar.
 */
-(void)getMovieDetailWithMovieID:(NSNumber*)movieID;

@end
