jQuery(function(){var t;return t=$("#err_log_user_id").html(),console.log(t),$("#err_log_department_id").change(function(){var e,r;return e=$("#err_log_department_id :selected").text(),r=$(t).filter("optgroup[label="+e+"]").html(),console.log(r),r?$("#err_log_user_id").html(r):$("#err_log_user_id").empty()})});