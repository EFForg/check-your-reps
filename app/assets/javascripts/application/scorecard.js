//= require tablesort/dist/tablesort.min.js

/* global Tablesort */
document.addEventListener('DOMContentLoaded', () => {
  const table = document.getElementById('all-congress-members-table');
  if (table) { Tablesort(table); }
});

/* underline the active sorter */
document.addEventListener('turbolinks:load', () => {
  headers = Array.from(document.getElementsByTagName('th'))
  for (i=0; i < headers.length; i++) {
    headers[i].addEventListener("click", handleTableSort);
  };
});

var handleTableSort = function() {
  const headers = Array.from(document.getElementsByTagName('th'));

  for (i=0; i < headers.length; i++) {
    th = headers[i]
    if (th.attributes.getNamedItem('aria-sort')) {
      th.classList.add('selected');
    } else {
      th.classList.remove('selected');
    }
  };
};
