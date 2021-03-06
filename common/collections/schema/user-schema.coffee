cart = new SimpleSchema
  last_modified:
    type: Date
    autoValue: ->
      if @isUpdate
        new Date()
  status:
    type: String
    optional:true
    allowedValues: ['active', 'pending', 'upcoming', 'complete', 'expiring', 'expired']

notificationsSchema = new SimpleSchema
  soldOutEmails:
    type: Boolean
    label: "Sold Out Emails"
    optional: true
    # ngAutoform:
#       type: 'checkbox'
#       roles: ['producer']
  newProductEmails:
    type: Boolean
    label: "Notifications for New Products from Liked Producers"
    optional: true
    # ngAutoform:
#       type: 'checkbox'
  earlyShoppingReminders:
    type: Boolean
    label: "Receive Notifications when products I care about are near their weekly deadline"
    optional: true
  lastCallReminder:
    type: Boolean
    label: "Receive a Notification on Sunday reminding me to shop."
    optional: true
  sms:
    type: Boolean
    label: "Receive Notifications by SMS"
    optional: true
  email:
    type: Boolean
    label: "Receive Notifications by email"
    optional: true


profile = new SimpleSchema
  name:
    type: String
  customerNumber:
    type: Number
    unique: true
    autoValue: ->
      if @isInsert
        return incrementCounter Counters, 'customerNumber'
  address:
    type: String
    optional:true
  deliveryAddress:
    type: Object
    optional:true
    blackbox:true
  phone:
    type: String
    optional:true
  cart:
    type: cart
    optional: true
  lastOrder:
    label: "Last Order"
    type: [String]
    optional:true
    defaultValue: []
  favourites:
    label: "Last Order"
    type: [String]
    optional:true
    defaultValue: []
  notifications:
    label: "Notification Settings"
    type: notificationsSchema
    optional: true
  balance: type: Number, decimal: true, defaultValue: 0
  gst: type: String, optional: true, max: 30
  gstCycle: type: Number, optional: true, min: 1
  companyName: type: String, optional:true
  summary: type: String, optional:true
  bio: type: String, optional:true
  bankAccount: type: String, optional: true
  shareAddress: type: Boolean, optional: true
  logo: type: Object, blackbox: true, optional:true
  personalPic: type: Object, blackbox:true, optional:true
  banner: type: Object, blackbox: true, optional: true
  website: type: String, optional: true
  facebook: type: String, optional: true
  chemicals: type: String, optional:true
  certification: type: String, optional: true
  video: type: String, optional: true

Schema = new SimpleSchema
  emails:
    type: [Object]
      # this must be optional if you also use other login services like facebook
      # but if you use only accounts-password then it can be required
    optional: true
  "emails.$.address":
    type: String
    regEx: SimpleSchema.RegEx.Email

  "emails.$.verified":
    type: Boolean

  createdAt:
    type: Date
    defaultValue: new Date()

  profile:
    type: profile
    optional: true

  services:
    type: Object
    optional: true
    blackbox: true
  # Braintree id to get stored payment methods
  customerId:
    type: String
    optional: true

  ###
   Add `roles` to your schema if you use the meteor-roles package.
   Option 1: Object type
   If you specify that type as Object you must also specify the
   `Roles.GLOBAL_GROUP` group whenever you add a user to a role.
   Example:
   Roles.addUsersToRoles(userId ["admin"] Roles.GLOBAL_GROUP);
   You can't mix and match adding with and without a group since
   you will fail validation in some cases.
  roles: {
      type: Object
      optional: true
      blackbox: true
  }
  ###

  ###
   Option 2: [String] type
   If you are sure you will never need to use role groups then
   you can specify [String] as the type
  ###
  roles:
    type: [String]
    optional: true


Meteor.users.attachSchema Schema
