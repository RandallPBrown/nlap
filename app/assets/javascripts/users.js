$(document).ready(function(){
     userTableToggleVal();
});

$('#userTableToggle').on('change',function(){
  userTableToggleVal();
});

function userTableToggleVal() {
  if (($('#occurrenceToggle').prop('checked', true) == true)) {
    $('#userEntryTable').show();
    $('#userDapTable').hide();
  } else if (($('#dapToggle').prop('checked', true) == true)) {
    $('#userEntryTable').hide();
    $('#userDapTable').show();
  }
}