#AddressBookHelper

#Installation

1. Drag AddressBookHelper.h and AddressBookHelper.m

##Usage

###Check permission to access contact information

```objective-c
 [[AddressBookHelper alloc] checkPermission:^(id response) {
      AddressBookPermission *permission =  (AddressBookPermission *)response);
      //user deny permission to access
      //permission.ReturnType == ADDRESS_NO_AUTORIZED;
      
      //user disabled app permission
      //permission.ReturnType == ADDRESS_PERMISSION_DISABLED;
      
      //permission.ReturnType == ADDRESS_SUCCESS;
 }];
```

###Retrieve all contacts

```objective-c

 [[AddressBookHelper alloc]  allContact:^(id response) {


}];

```





