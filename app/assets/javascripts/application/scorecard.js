//= require tablesort/dist/tablesort.min.js

/* global Tablesort */
document.addEventListener('DOMContentLoaded', () => {
  const table = document.getElementById('all-congress-members-table');
  if (table) { Tablesort(table); }
});
