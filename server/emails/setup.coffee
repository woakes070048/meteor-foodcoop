Templates = {}

Mailer.config
  from: 'Kai kohekohe Food Co-op <kaikohe.cooperative@gmail.com>'
  replyTo: 'Kai kohekohe Food Co-op <kaikohe.cooperative@gmail.com>'

Templates.contactMessage = 
  path: 'contact/contact-email.html'

Templates.wholesaleInvoiceEmail =
  path: 'invoice/invoice-email.html'
  scss: 'invoice/invoice-email.scss'

Templates.confirmOrderEmail =
  path: 'order/confirmation-email.html'

Templates.subscriptionConfirmation =
  path: 'order/subscription-confirmation-email.html'

Templates.hubReminder =
  path: 'hub/hub-reminder.html'

Templates.applications =
  path: 'apply/producer-application.html'

Meteor.startup ->
  Mailer.init
    templates: Templates
    layout:
      name:'emailLayout'
      path: 'email-layout.html'
      scss: 'email-layout.scss'
    helpers:
      companyName: "Kai kohekohe Food Co-op"
      bankAccount: "06-0333-0082913-03"
      GSTNumber: "113-091-103"
      deliveryDay: () ->
        day = GetDeliveryDay()
        moment(day).calendar null,
          nextDay : '[Tomorrow]',
          sameDay : '[Today]',
          nextWeek : '[this] dddd',
          sameElse : 'dddd MMMM dd, yyyy'
      duration: () ->
        #similar to userCartCtrl weeksRemaining function
        end = moment(@end_date).startOf('day');
        weeks = Math.abs moment(end).diff(moment(@start_date).startOf('day'), 'weeks')
        if (weeks == 0)
          weeks++
        "#{weeks} weeks"

      totalPrice: () ->
          price = @qty * @price * (Meteor.settings.public.markup / 100 + 1)
          return "$#{price.toFixed(2)}"

      total: () ->
        #enspired by userCartCtrl total function
        total = _.reduce @items, (t, item) ->
          duration = Math.abs moment(item.end_date).startOf('day').diff(moment(item.start_date).startOf('day'), 'weeks')

          if duration == 0
            duration++
          t += item.qty * item.productDetails.price * duration
        , 0
        total


  # Mailer.send
  #   to: "nobody <nobody@nowhere.com"
  #   subject: "Collect your Order Today"
  #   template: "wholesaleInvoiceEmail"
  #   data: {recipient:"Sean"}
