  jQuery(function() {
  var users;
  users = $('#err_log_user_id').html();
  console.log(users);
  return $('#err_log_department_id').change(function() {
    var department, options;
    department = $('#err_log_department_id :selected').text();
    options = $(users).filter("optgroup[label=" + department + "]").html();
    console.log(options);
    if (options) {
      return $('#err_log_user_id').html(options);
    } else {
      return $('#err_log_user_id').empty();
    }
  });
});



