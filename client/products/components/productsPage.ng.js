function ProductsPageCtrl ($scope, $state, $stateParams, $reactive) {
  
  "ngInject";
  
  $reactive(this).attach($scope)

  this.go = $state.go;
  
  this.showGST = true;
  
  this.subscribe('categories');
  this.subscribe('product-names');
  this.subscribe('producer', () => [this.getReactively('stateParams.producer')]);

  
  this.stateParams = angular.copy($stateParams);
  
  this.query = {
    category: $stateParams.category,
    producer: $stateParams.producer
  };
  

  this.helpers({
    categories() {
      return Categories.find()
    },
    products() {
      return Products.find()
    }
  })
  
  this.options = {
    sort: {name: 1}
  };

  this.querySearch   = querySearch;
  this.selectedItemChange = selectedItemChange;
  this.searchTextChange   = searchTextChange;
  
  this.autorun( () => {
    if (this.stateParams.category) {
      this.selectedCategory = _.indexOf( _.pluck(Categories.find().fetch(), 'name'), this.stateParams.category) + 1;
    } else {
      this.selectedCategory = 0;
    }
  })
  
  
  function querySearch (query) {
    var results = query ? this.products.filter( createFilterFor(query) ) : this.products;
    return results;
  }
  function searchTextChange(text) {
    console.log('Text changed to ' + text);
  }
  function selectedItemChange(item) {
    $state.go('productDetails', {productId: item._id})
  }
  function createFilterFor(query) {
    var lowercaseQuery = angular.lowercase(query);
    return function filterFn(product) {
      return (product.name.toLowerCase().indexOf(lowercaseQuery) !== -1);
    };
  }

}


angular.module("food-coop").component("productsPage", {
  controller: ProductsPageCtrl,
  controllerAs: 'store',
  templateUrl: 'client/products/components/products-list.ng.html'
});
