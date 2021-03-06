import { check } from 'meteor/check';
import { Deliveries } from '../collection';
import { Meteor } from 'meteor/meteor';


export function addDelivery(delivery, userId) {
  check(userId, String);
  const user = Meteor.users.findOne(userId);
  for (let i = 0; i < delivery.deliveryDays.length; i++) {
    const d = delivery.deliveryDays[i];
    Deliveries.insert({
      address: delivery.address,
      userId,
      userName: user.profile.name,
      customerNumber: user.profile.customerNumber,
      deliveryDay: new Date(d),
      cost: delivery.deliveryMethod.cost,
      deliveryId: delivery.deliveryMethod._id,
      method: delivery.deliveryMethod.title,
    });
  }
}

Meteor.methods({
  addDelivery,
});
