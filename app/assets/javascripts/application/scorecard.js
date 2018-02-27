//= require tablesort/dist/tablesort.min.js

/* global Tablesort */
document.addEventListener('turbolinks:load', () => {
  const table = document.getElementById('all-congress-members-table');
  if (table) { Tablesort(table); }
});
