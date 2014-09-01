//
//  JSONParser.h
//  HelloWorld
//
//  Created by Suniket on 17/05/13.
//
//

#import <Foundation/Foundation.h>
@protocol  JSONParserDelegate <NSObject>

@required
- (void)DidBegin;
- (void)DidFail:(NSString *)errorstr;
- (void)DidFinish:(id)data;

@end

@interface JSONParser : NSObject
{
    id json;
    NSURLConnection *connection;
    NSMutableData *responseData;

   }
@property (nonatomic, weak) id <JSONParserDelegate> delegate;

-(void)parseData:(NSDictionary *) dict WebServiceName:(NSString*)WebserviceString;

@end
