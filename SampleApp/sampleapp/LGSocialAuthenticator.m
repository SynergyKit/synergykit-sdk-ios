#import "LGSocialAuthenticator.h"
#import "FBSDKLoginManager.h"
#import "FBSDKLoginManagerLoginResult.h"
#import <FBSDKCoreKit/FBSDKGraphRequest.h>
#import "TWAPIManager.h"
#import "GTMOAuth2Authentication.h"
#import "SKHelper.h"

@interface LGSocialAuthenticator()

@property (strong, nonatomic) NSMutableDictionary* facebookSessionData;

@property (strong, nonatomic) NSArray* twitterAccounts;
@property (strong, nonatomic) void (^twitterCompletion) (NSDictionary *userData, NSError *error);

@property (strong, nonatomic) void (^googleCompletion) (NSDictionary *userData, NSError *error);

@end

@implementation LGSocialAuthenticator

@synthesize facebookSessionData;
@synthesize twitterAccounts;
@synthesize twitterCompletion;
@synthesize googleCompletion;

#pragma mark
#pragma mark Singleton
#pragma mark

+(id) sharedInstance
{
    static dispatch_once_t once;
    static LGSocialAuthenticator *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
        
        [sharedInstance setAuthenticatorTwitterActionSheetCancelButton:@"Cancel"];
        [sharedInstance setAuthenticatorTwitterActionSheetTitle:@"Select a Twitter account"];
    });
    
    return sharedInstance;
}

#pragma mark
#pragma mark Facebook
#pragma mark

-(FBSDKAccessToken *) isFacebookSessionValid
{
    return [FBSDKAccessToken currentAccessToken];
}

-(void) readFacebookDataWithScope:(NSArray *)scope Completion:(void (^) (NSDictionary *userData, NSError *error))completion
{
    facebookSessionData = [NSMutableDictionary new];
    FBSDKAccessToken *token = [self isFacebookSessionValid];
    
    void (^tokenHanler) (FBSDKAccessToken *token) = ^(FBSDKAccessToken *t)
    {
        if (t.tokenString) facebookSessionData[@"tokenString"] = t.tokenString;
        if (t.permissions) facebookSessionData[@"permissions"] = t.permissions;
        if (t.declinedPermissions) facebookSessionData[@"declainedPermissions"] = t.declinedPermissions;
        if (t.userID) facebookSessionData[@"_id"] = t.userID;
        if (t.expirationDate) facebookSessionData[@"expirationDate"] = t.expirationDate;
        if (t.refreshDate) facebookSessionData[@"refreshData"] = t.refreshDate;
        
        FBSDKGraphRequest *requet = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil];
        
        [requet startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
            
            if (error == nil && result != nil)
            {
                [facebookSessionData addEntriesFromDictionary:result];
                completion(facebookSessionData, nil);
            }
            else
            {
                completion(nil, error);
            }
        }];
    };
    
    if (token)
    {
        tokenHanler(token);
    }
    else
    {
        FBSDKLoginManager *loginManager = [FBSDKLoginManager new];
        
        [loginManager logInWithReadPermissions:scope handler:^(FBSDKLoginManagerLoginResult *result, NSError *error)
        {
            if (result.isCancelled)
            {
                NSError *error = [[NSError alloc] initWithDomain:@"Facebook Authentication" code:0 userInfo:@{NSLocalizedDescriptionKey: @"User canceled login."}];
                completion(nil, error);
            }
            else
            {
                tokenHanler(result.token);
            }
        }];
    }
    
    
}

-(void) invalidateFacebookSession
{
    if ([self isFacebookSessionValid])
    {
        FBSDKLoginManager *loginManager = [FBSDKLoginManager new];
        [loginManager logOut];
    }
}

#pragma mark
#pragma mark Twitter
#pragma mark

-(void) readTwitterDataWithCompletion:(void (^) (NSDictionary *userData, NSError *error))completion
{
    [self prepareTwitter:^(NSError *error) {
        if (!error)
        {
            twitterCompletion = completion;
            [self selectTwitterAccount];
        }
        else
        {
            completion(nil, error);
        }
    }];
}

-(void) prepareTwitter:(void (^) (NSError *error))completion
{
    ACAccountStore * accountStore = [ACAccountStore new];
    
    if ([TWAPIManager isLocalTwitterAccountAvailable])
    {
        ACAccountType *type = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        
        [accountStore requestAccessToAccountsWithType:type options:nil completion:^(BOOL granted, NSError *error) {
            if (granted)
            {
                twitterAccounts = [accountStore accountsWithAccountType:type];
                completion(nil);
            }
            else
            {
                NSError *error = [[NSError alloc] initWithDomain:@"Twitter Authentication" code:0 userInfo:@{NSLocalizedDescriptionKey: @"Access to the Twitter accounts isn't granted."}];
                completion(error);
            }
        }];
    }
    else
    {
        NSError *error = [[NSError alloc] initWithDomain:@"Twitter Authentication" code:0 userInfo:@{NSLocalizedDescriptionKey: @"There isn't any Twitter account."}];
        completion(error);
    }
}

-(void) selectTwitterAccount
{
    if (twitterAccounts && twitterAccounts.count > 0)
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:_authenticatorTwitterActionSheetTitle delegate:self cancelButtonTitle:_authenticatorTwitterActionSheetCancelButton destructiveButtonTitle:nil otherButtonTitles: nil];
        
        if (twitterAccounts.count == 1)
        {
            // Auto select
            [self actionSheet:actionSheet clickedButtonAtIndex:0];
            return;
        }
        
        for (ACAccount *account in twitterAccounts)
        {
            [actionSheet addButtonWithTitle:account.username];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIView *view = [[[[UIApplication sharedApplication] keyWindow] subviews] lastObject];
            [actionSheet showInView:view];
        });
    }
    else
    {
        NSError *error = [[NSError alloc] initWithDomain:@"Twitter Authentication" code:0 userInfo:@{NSLocalizedDescriptionKey: @"You don't have any Twitter account."}];
        twitterCompletion(nil, error);
    }
}

-(void) authenticateTwitterAccount:(ACAccount *)account
{
    [TWAPIManager registerTwitterAppKey:_twitterConsumerKey andAppSecret:_twitterConsumerSecret];
    [TWAPIManager performReverseAuthForAccount:account withHandler:^(NSData *responseData, NSError *error) {
        if (responseData != nil)
        {
            NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
            NSDictionary *twitterUser = [self parseTwitterQueryString:responseString];
            
            NSMutableDictionary *data = [NSMutableDictionary new];
            
            if (twitterUser[@"user_id"]) data[@"_id"] = twitterUser[@"user_id"];
            if (twitterUser[@"screen_name"]) data[@"screenName"] = twitterUser[@"screen_name"];
            if (_twitterConsumerKey) data[@"consumerKey"] = _twitterConsumerKey;
            if (_twitterConsumerSecret) data[@"consumerSecret"] = _twitterConsumerSecret;
            if (twitterUser[@"oauth_token"]) data[@"authToken"] = twitterUser[@"oauth_token"];
            if (twitterUser[@"oauth_token_secret"]) data[@"authTokenSecret"] = twitterUser[@"oauth_token_secret"];
            
            twitterCompletion(data, nil);
        }
        else
        {
            twitterCompletion(nil, error);
        }
    }];
}

-(NSDictionary *) parseTwitterQueryString:(NSString *)query
{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    for (NSString *pair in pairs)
    {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
        NSString *key = [((NSString *) elements[0]) stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *value = [((NSString *) elements[1]) stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        dict[key] = value;
    }
    return [dict copy];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([actionSheet.title isEqualToString:_authenticatorTwitterActionSheetTitle])
    {
        if (actionSheet.cancelButtonIndex != buttonIndex)
        {
            [self authenticateTwitterAccount:twitterAccounts[buttonIndex-1]];
        }
        else
        {
            NSError *error = [[NSError alloc] initWithDomain:@"Twitter Authentication" code:0 userInfo:@{NSLocalizedDescriptionKey: @"No twitter account selected."}];
            twitterCompletion(nil, error);
            twitterCompletion = nil;
        }
    }
}

#pragma mark
#pragma mark Google
#pragma mark

-(void) readGoogleDataWithScope:(NSArray *)scope Completion:(void (^) (NSDictionary *userData, NSError *error))completion
{
    NSString *clientId = _googleClientId;
    if (clientId)
    {
        GPPSignIn *signIn = [GPPSignIn sharedInstance];
        signIn.clientID = clientId;
        signIn.scopes = scope;
        signIn.delegate = self;
        
        googleCompletion = completion;
        [signIn authenticate];
    }
    else
    {
        NSError *error = [[NSError alloc] initWithDomain:@"Google Authentication" code:0 userInfo:@{NSLocalizedDescriptionKey: @"Google clientID is not set."}];
        completion(nil, error);
    }
}

-(void) invalidateGoogleSession
{
    [[GPPSignIn sharedInstance] disconnect];
}

-(void)finishedWithAuth:(GTMOAuth2Authentication *)auth error:(NSError *)error
{
    if (error == nil && auth != nil)
    {
        NSMutableDictionary *userData = [NSMutableDictionary new];
        
        userData[@"accessToken"] = auth.accessToken;
        userData[@"tokenType"] = auth.tokenType;
        userData[@"clientId"] = auth.clientID;
        userData[@"refreshToken"] = auth.refreshToken;
        userData[@"expirationDate"] = auth.expirationDate;
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.googleapis.com/oauth2/v1/userinfo?alt=json&access_token=%@", auth.accessToken]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:5];
        request.HTTPMethod = @"GET";
        
        NSError *getError = nil;
        NSURLResponse *response = nil;
        
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&getError];
        
        if (getError == nil && responseData != nil)
        {
            NSError *deserializationError = nil;
            NSDictionary *user = [SKHelper fromNSDataToNSDictionary:responseData error:&deserializationError];
            
            if (user)
            {
                if (user[@"gender"]) userData[@"gender"] = user[@"gender"];
                if (user[@"locale"]) userData[@"locale"] = user[@"locale"];
                if (user[@"id"]) userData[@"_id"] = user[@"id"];
                if (user[@"verified_email"]) userData[@"verifiedEmail"] = user[@"verified_email"];
                if (user[@"picture"]) userData[@"picture"] = user[@"picture"];
                if (user[@"email"]) userData[@"email"] = user[@"email"];
                if (user[@"link"]) userData[@"profileLink"] = user[@"link"];
                if (user[@"given_name"]) userData[@"firstName"] = user[@"given_name"];
                if (user[@"family_name"]) userData[@"lastName"] = user[@"family_name"];
                
                googleCompletion(userData, nil);
            }
            else
            {
                googleCompletion(nil, deserializationError);
            }
        }
        else
        {
            googleCompletion(nil, getError);
        }
    }
    else
    {
        googleCompletion(nil, error);
    }
}

@end
