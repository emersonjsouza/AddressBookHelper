//
//  AddressBookHelper.m
//
//
//  Created by Emerson Jose on 7/5/15.
//  Copyright (c) 2015 DevSouza Mobile. All rights reserved.
//

#import "AddressBookHelper.h"

@implementation AddressBookHelper


-(void)allContact:(void(^)(id response))callBack
{
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(nil, nil);
    NSArray *allContacts = (__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBookRef);
    
    NSMutableArray *contacts = [NSMutableArray new];
    
    for (id record in allContacts){
        
        ABRecordRef thisContact = (__bridge ABRecordRef)record;
        
        ABMultiValueRef phones = ABRecordCopyValue(thisContact, kABPersonPhoneProperty);
        NSString *firstName = (__bridge  NSString*)ABRecordCopyValue(thisContact, kABPersonFirstNameProperty);
        NSString *lastName  = (__bridge  NSString*)ABRecordCopyValue(thisContact, kABPersonLastNameProperty);
        NSString *email  =(__bridge  NSString*)ABRecordCopyValue(thisContact, kABPersonEmailProperty);
        
        NSString* phone;
        
        for(CFIndex i = 0; i <= ABMultiValueGetCount(phones); i++) {
            
            NSString *phoneLabel = (__bridge  NSString*)ABMultiValueCopyLabelAtIndex(phones, i);
            
            if([phoneLabel isEqualToString:(NSString *)kABPersonPhoneMobileLabel])
            {
                phone = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phones, i);
            }
            else if (phoneLabel != nil)
            {
                phone = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phones, i);
                break;
            }
        }
        
        
        if([[NSString stringWithFormat:@"%@",email] rangeOfString:@"ABMultiValueRef"].length > 0)
        {
            email = @"";
        }
        
        [contacts addObject:@{@"name" : [NSString stringWithFormat:@"%@ %@",firstName,lastName == nil ? @"": lastName], @"email": email, @"phone" : phone == nil ? @"": phone}];
        
    }
    
    callBack(contacts);
}

-(void)checkPermission:(void(^)(id response))callback
{
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(nil, nil);
    
    AddressBookPermission *permissionResponse = [AddressBookPermission new];
    permissionResponse.ReturnType = ADDRESS_SUCCESS;
    
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
        
        //wait for user permission delay (10sec )
        dispatch_async(dispatch_get_main_queue(), ^{
            
            ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
            if (!granted)
                    //fail because no have permission to access.
                    permissionResponse.ReturnType = ADDRESS_NO_AUTORIZED;
            });
            
        });
        
    }
    else if (ABAddressBookGetAuthorizationStatus() != kABAuthorizationStatusAuthorized) {
        //faile because disabled contact permission of App.
        permissionResponse.ReturnType = ADDRESS_PERMISSION_DISABLED;
    }

    callback(permissionResponse);
}

@end

#pragma mark - AdressBookResponse
@implementation AddressBookPermission

@end


