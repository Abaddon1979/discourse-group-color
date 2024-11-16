// plugins/discourse-group-color/assets/javascripts/discourse/routes/admin/group-colors.js.es6

import AdminRoute from 'discourse/routes/admin';

export default AdminRoute.extend({
  model() {
    return this.store.findAll('admin-group-color');
  }
});