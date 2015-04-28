#import <Foundation/Foundation.h>
#import "FBSDKAccessToken.h"
#import "GPPSignIn.h"

@interface LGSocialAuthenticator : NSObject <UIActionSheetDelegate, GPPSignInDelegate>

#pragma mark
#pragma mark Singleton
#pragma mark

+(id) sharedInstance;

#pragma mark
#pragma mark Properties
#pragma mark

@property (nonatomic) BOOL validFacebookSession;

@property (strong, nonatomic) NSString* googleClientId;
@property (strong, nonatomic) NSString* twitterConsumerKey;
@property (strong, nonatomic) NSString* twitterConsumerSecret;

@property (strong, nonatomic) NSString* authenticatorTwitterActionSheetTitle;
@property (strong, nonatomic) NSString* authenticatorTwitterActionSheetCancelButton;

#pragma mark
#pragma mark Facebook
#pragma mark

-(FBSDKAccessToken *) isFacebookSessionValid;
-(void) readFacebookDataWithScope:(NSArray *)scope Completion:(void (^) (NSDictionary *userData, NSError *error))completion;
-(void) invalidateFacebookSession;

#pragma mark
#pragma mark Twitter
#pragma mark

-(void) readTwitterDataWithCompletion:(void (^) (NSDictionary *userData, NSError *error))completion;

#pragma mark
#pragma mark Google
#pragma mark

-(void) readGoogleDataWithScope:(NSArray *)scope Completion:(void (^) (NSDictionary *userData, NSError *error))completion;
-(void) invalidateGoogleSession;



@end
