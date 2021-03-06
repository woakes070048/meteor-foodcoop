/* globals GetProductDeliveryDay */

import angular from 'angular';
import templateUrl from './cart-table.ng.html';

class CartTableController {
  constructor($scope, $reactive, $mdDialog) {
    'ngInject';

    $reactive(this).attach($scope);
    this.priceWithMarkup = item => Markup(item).total();
    this.totalWithMarkup = item => Markup(item).cartTotal();

    this.deliveryAlert = (ev, daysNotice) => {
      $mdDialog.show($mdDialog.alert()
        .clickOutsideToClose(true)
        .title(`This product is no longer available for ${GetNextDeliveryDay().format('MMMM D')}`)
        .textContent(`You will receive it on ${GetProductDeliveryDay(daysNotice).format('dddd, MMMM D')} instead`)
        .ariaLabel('Delivery Alert')
        .ok('Got it!')
        .targetEvent(ev)
      );
    };
  }
  delete(id) {
    this.onRemove({ id });
  }

  update(id, newQty, oldQty) {
    this.onUpdate({ id, newQty, oldQty });
  }
  deliveryWarning(daysNotice) {
    let d = daysNotice;
    if (daysNotice == null) {
      d = Meteor.settings.public.shoppingThreshold;
    }
    if (d && GetProductDeliveryDay(d).isAfter(GetNextDeliveryDay())) {
      return true;
    }
    return false;
  }
}

const name = 'cartTable';

export default angular.module(name, []).component(name, {
  controller: CartTableController,
  templateUrl,
  controllerAs: 'cart',
  bindings: {
    items: '<',
    user: '<',
    total: '<',
    shipping: '<',
    onRemove: '&',
    onUpdate: '&',
  },
});
