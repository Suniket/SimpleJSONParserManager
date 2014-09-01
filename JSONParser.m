//
//  JSONParser.m
//  HelloWorld
//
//  Created by Suniket on 17/05/13.
//
//

#import "JSONParser.h"
@implementation JSONParser
@synthesize delegate;


-(void)parseData:(NSDictionary *)dict WebServiceName:(NSString*)WebserviceString
{
    
    NSLog(@"WebserviceString---%@",WebserviceString);
    NSLog(@"dict::%@",dict);
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:WebserviceString]];
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
    //Origin: chrome-extension://hgmloofddffdnphfgcellkdfbfbjeloo
    [request setHTTPBody:postData];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];

}



- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    responseData = [NSMutableData data];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *error;
     NSMutableDictionary * ResponseDictionary = [NSJSONSerialization  JSONObjectWithData:responseData  options:kNilOptions error:&error];
    //NSLog(@"response data - %@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
    [self DidFinish:ResponseDictionary];
    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"error %@",error);
    [self DidFail:error.localizedDescription];
}

- (void)DidBegin
{
    
}

- (void)DidFail:(NSString *)errorstr
{
    if (delegate && [delegate respondsToSelector:@selector(DidFail:)])
    {
        [delegate DidFail:errorstr];
    }
}

- (void)DidFinish:(id)data 
{
    //encrypted data
    if (delegate && [delegate respondsToSelector:@selector(DidFinish:)])
    {
        [delegate DidFinish:data];
    }
}

@end
