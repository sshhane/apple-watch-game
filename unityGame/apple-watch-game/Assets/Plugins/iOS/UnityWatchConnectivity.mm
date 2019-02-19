#import "UnityWatchConnectivity.h"

@implementation SDKWatchSessionDelegate

@end

static SDKWatchSessionDelegate *delegateObject = nil;
static WCSession *session = nil;

// Converts C style string to NSString
NSString* CreateNSString (const char* string)
{
    if (string)
        return [NSString stringWithUTF8String: string];
    else
        return [NSString stringWithUTF8String: ""];
}

extern "C" {

    void _SendMessage (const char* content)
    {
        if (delegateObject == nil){
            delegateObject = [[SDKWatchSessionDelegate alloc] init];
        }

        if(WCSession.isSupported){
            session = WCSession.defaultSession;
            session.delegate = delegateObject;
            [session activateSession];
        }

        [session sendMessage:@{CreateNSString("json") : CreateNSString(content) } replyHandler:nil errorHandler:nil];
    }
    void _RecievedMessage (const char* content)
    {
        NSLog(@"_ReceivedMessage");
    }
}