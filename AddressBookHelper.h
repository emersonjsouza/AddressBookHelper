//
//  AddressBookHelper.h
//  AgendaOnline
//
//  Created by Emerson Jose on 7/5/15.
//  Copyright (c) 2015 DevSouza Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>
@import AddressBook;


enum AddressState
{
    ADDRESS_NO_AUTORIZED = 0,
    ADDRESS_PERMISSION_DISABLED = 1,
    ADDRESS_SUCCESS = 2
};

@interface AddressBookHelper : NSObject

-(void)allContact:(void(^)(id response))callBack;

-(void)checkPermission:(void(^)(id response))callback;


@end


@interface AddressBookPermission : NSObject

@property enum AddressState ReturnType;

@end;




