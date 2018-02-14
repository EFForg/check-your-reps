// $(function(){
//   $('button.white-button').click(function() {
//     $(this).addClass('clicked');
//   })
//  });
$(function () {
  $('button.white-button').click(() => {
    $(this).css({ background: 'black', color: 'white' });
  });
});
