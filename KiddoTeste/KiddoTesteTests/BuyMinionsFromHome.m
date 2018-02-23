//
//  BuyMinionsFromHome.m
//  KiddoTesteTests
//
//  Created by Aloisio Mello on 23/02/18.
//  Copyright © 2018 Aloisio Mello. All rights reserved.
//

#import <KIF/KIF.h>

@interface BuyMinionsFromHome : KIFTestCase

@end

@implementation BuyMinionsFromHome

-(void)beforeAll{
    [tester tapViewWithAccessibilityLabel:@"Home"];
}

-(void)testBuyMinionsAndFavorite{
    [tester waitForTappableViewWithAccessibilityLabel:@"Minions"];
    [tester tapViewWithAccessibilityLabel:@"Minions"];
    [tester waitForTappableViewWithAccessibilityLabel:@"COMPRAR"];
    [tester tapViewWithAccessibilityLabel:@"COMPRAR"];
    [tester waitForTappableViewWithAccessibilityLabel:@"SD R$5,00 Alugar: 3 Dias Applestore"];
    [tester tapViewWithAccessibilityLabel:@"SD R$5,00 Alugar: 3 Dias Applestore"];
    [tester waitForTappableViewWithAccessibilityLabel:@"COMPRAR"];
//    [tester tapViewWithAccessibilityLabel:@"Voltar"];
//    [tester tapViewWithAccessibilityLabel:@"Favoritos"];
//    [tester waitForTappableViewWithAccessibilityLabel:@"Minions"];
}

@end
