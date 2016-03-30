//
//  GameOver.m
//  Galactic Courier
//
//  Created by Jeremiah Bonham on 5/14/15.
//  Copyright (c) 2015 Jeremiah.Bonham. All rights reserved.
//

#import "GameOver.h"
#import "LevelOne.h"
#import "Title.h"
@import iAd;

@interface GameOver() <ADBannerViewDelegate, UIAlertViewDelegate>
{

    SKSpriteNode *bg1;
    SKNode *brokenShip;
    SKSpriteNode *stars1;
    SKAction *playExplode;
    
}

@property NSMutableArray *explosionTextures;
@property (nonatomic) BOOL pausesIncomingScene;
@property (nonatomic, strong) ADBannerView *ads;
@property (nonatomic) BOOL adVisible;
@end

@implementation GameOver
@synthesize pausesIncomingScene;

-(instancetype)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
    }
    return self;
}

-(void)didMoveToView:(SKView *)view {
    self.scaleMode = SKSceneScaleModeAspectFill;
    pausesIncomingScene = NO;

    playExplode = [SKAction playSoundFileNamed:@"explosion.mp3" waitForCompletion:YES];
    [self runAction:playExplode];

    bg1 = [SKSpriteNode spriteNodeWithImageNamed:@"bg020"];
    bg1.anchorPoint = CGPointZero;
    bg1.position = CGPointMake(0, 0);
    bg1.zPosition = .5;
    [self addChild:bg1];
    
    
    _ads = [[ADBannerView alloc] initWithFrame:CGRectZero];
    self.ads.delegate = self;
    [_ads setFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 100)];
    
    stars1 = [SKSpriteNode spriteNodeWithImageNamed:@"stars010.png"];
    stars1.anchorPoint = CGPointZero;
    stars1.position = CGPointMake(0, 0);
    stars1.zPosition = .2;
    [self addChild:stars1];
    
    //load explosions
    SKTextureAtlas *explosionAtlas = [SKTextureAtlas atlasNamed:@"explosion"];
    NSArray *textureNames = [explosionAtlas textureNames];
    _explosionTextures = [NSMutableArray new];
    for (NSString *name in textureNames) {
        SKTexture *texture = [explosionAtlas textureNamed:name];
        [_explosionTextures addObject:texture];
    }
    
    
    brokenShip = [SKSpriteNode spriteNodeWithImageNamed:@"explosion.png"];
    brokenShip.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    //brokenShip.scale = 1.5;
    brokenShip.zPosition = .5;
    [self addChild:brokenShip];
    
    
    SKSpriteNode *explosion = [SKSpriteNode spriteNodeWithTexture:[_explosionTextures objectAtIndex:0]];
    explosion.scale = 3.5;
    explosion.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    explosion.zPosition = .6;
    [self addChild:explosion];
    
    SKAction *explosionAction = [SKAction animateWithTextures:_explosionTextures timePerFrame:0.1];
    SKAction *remove = [SKAction removeFromParent];
    [explosion runAction:[SKAction sequence:@[explosionAction,remove]]];
    
    SKLabelNode *gameOver = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
        
    gameOver.text = @"GAME OVER";
    gameOver.fontColor = [SKColor whiteColor];
    gameOver.fontSize = 40;
    gameOver.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    gameOver.zPosition = 1;
    [self addChild:gameOver];
    
    SKLabelNode *tryAgain = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
        
    tryAgain.text = @"Tap To Continue";
    tryAgain.fontColor = [SKColor whiteColor];
    tryAgain.fontSize = 20;
    tryAgain.position = CGPointMake(self.frame.size.width/2, -50);
    tryAgain.zPosition = 1;
    SKAction *moveLabel = [SKAction moveToY:(self.frame.size.height/2 - 40) duration: 1.0];
    [tryAgain runAction:moveLabel];
    
    [self addChild:tryAgain];
    
    
//    SKLabelNode *score = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
//
//    score.text = @"TEST";
//    score.fontColor = [SKColor whiteColor];
//    score.fontSize = 40;
//    score.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 50);
//    [self addChild:score];
    
    

};

-(void)bannerViewDidLoadAd:(ADBannerView *)banner{
    
    if (!_adVisible){
        
        if (_ads.superview == nil){
            
            [self.view addSubview:_ads];
            
        }
        
        [UIView beginAnimations:@"animateAdBannerShow" context:NULL];
        _ads.frame = CGRectOffset(_ads.frame, 0, -_ads.frame.size.height);
        
        [UIView commitAnimations];
        
        _adVisible = YES;
        
    }
    
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    
    NSLog(@"Failed to load an Ad!");
    
    if (_adVisible){
        
        [UIView beginAnimations:@"animateAdBannerHide" context:NULL];
        _ads.frame = CGRectOffset(_ads.frame, 0, _ads.frame.size.height);
        
        [UIView commitAnimations];
        
        _adVisible = NO;
        
    }
    
}

-(void)bannerViewActionDidFinish:(ADBannerView *)banner{
    
    _ads.delegate = nil;
    [_ads removeFromSuperview];
    
}



-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_ads removeFromSuperview];
    Title *title = [Title sceneWithSize:self.size];

    [self.view presentScene:title transition:[SKTransition doorsOpenHorizontalWithDuration:(1.25)]];
}

@end
