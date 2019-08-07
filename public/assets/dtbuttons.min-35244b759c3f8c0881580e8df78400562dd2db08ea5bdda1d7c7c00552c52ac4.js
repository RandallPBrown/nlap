/*!
 Bootstrap integration for DataTables' Buttons
 ©2016 SpryMedia Ltd - datatables.net/license
*/

(function(c){"function"===typeof define&&define.amd?define(["jquery","datatables.net-bs4","datatables.net-buttons"],function(a){return c(a,window,document)}):"object"===typeof exports?module.exports=function(a,b){a||(a=window);b&&b.fn.dataTable||(b=require("datatables.net-bs4")(a,b).$);b.fn.dataTable.Buttons||require("datatables.net-buttons")(a,b);return c(b,a,a.document)}:c(jQuery,window,document)})(function(c,a,b,d){a=c.fn.dataTable;c.extend(!0,a.Buttons.defaults,{dom:{container:{className:"list-group"},
button:{className:"list-group-item list-group-item-action bg-dark text-white font-weight-bold text-uppercase text-center"},collection:{tag:"div",className:"dt-button-collection dropdown-menu",button:{tag:"a",className:"dt-button dropdown-item",active:"active",disabled:"disabled"}}}});a.ext.buttons.collection.className+=" dropdown-toggle";a.ext.buttons.collection.rightAlignClassName="dropdown-menu-right";return a.Buttons});
