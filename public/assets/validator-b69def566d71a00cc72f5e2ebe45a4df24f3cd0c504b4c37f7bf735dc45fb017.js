

$("#estForm").submit(function(e){
        e.preventDefault();
    });

$("#estForm2").submit(function(e){
        e.preventDefault();
    });

// SMOOTH GLIDE SECTION TRANSITIONS

$('#logoToggle').on('click',function(){
     glideToggle();
     smootheGlide();
});

function glideToggle() {
      $('#logoToggle').toggleClass("active");
};

function smootheGlide(e) {
    if ($('#logoToggle').hasClass("active") === true) {
        $('#failureCause').on('focus',function(){
            $('html, body').animate({
                scrollTop: $("#infoBlock").offset().top
            }, 800);
        });

        $('#warrantyLink').on('focus',function(){
            $('html, body').animate({
                scrollTop: $("#verificationBlock").offset().top
            }, 800);
        });

        $('#skuVerification').on('focus',function(){
            $('html, body').animate({
                scrollTop: $("#verificationBlock").offset().top
            }, 800);
        });

        $('#originalPrice').on('focus',function(){
            $('html, body').animate({
                scrollTop: $("#liabilitiesBlock").offset().top
            }, 800);
        });

        $('#limitLiability').on('focus',function(){
            $('html, body').animate({
                scrollTop: $("#liabilitiesBlock").offset().top
            }, 800);
        });

        $('#totalParts').on('focus',function(){
            $('html, body').animate({
                scrollTop: $("#expenseBlock").offset().top
            }, 800);
        });

        $('#failureCause2').on('focus',function(){
            $('html, body').animate({
                scrollTop: $("#infoBlock2").offset().top
            }, 800);
        });

        $('#warrantyLink2').on('focus',function(){
            $('html, body').animate({
                scrollTop: $("#verificationBlock2").offset().top
            }, 800);
        });

        $('#skuVerification2').on('focus',function(){
            $('html, body').animate({
                scrollTop: $("#verificationBlock2").offset().top
            }, 800);
        });

        $('#originalPrice2').on('focus',function(){
            $('html, body').animate({
                scrollTop: $("#liabilitiesBlock2").offset().top
            }, 800);
        });

        $('#limitLiability2').on('focus',function(){
            $('html, body').animate({
                scrollTop: $("#liabilitiesBlock2").offset().top
            }, 800);
        });

        $('#totalParts2').on('focus',function(){
            $('html, body').animate({
                scrollTop: $("#expenseBlock2").offset().top
            }, 800);
        });        
  } else {

  }
}

// Keypress Event Listeners

$('#originalPrice').on('blur',function(){
     calculateLiabilities();
});

$('#previousPaid').on('blur',function(){
     calculateLiabilities();
});

$('#totalParts').on('blur',function(){
     calculateExpenseCharge();
     calculateLOL();
});

$('#totalLabor').on('blur',function(){
     calculateExpenseCharge();
     calculateLOL();
});

$('#totalTax').on('blur',function(){
     calculateExpenseCharge();
     calculateLOL();
});

$('#totalMileage').on('blur',function(){
     calculateExpenseCharge();
     calculateLOL();
});

$('#totalMisc').on('blur',function(){
     calculateExpenseCharge();
     calculateLOL();
});

$('#totalDeductible').on('blur',function(){
     calculateExpenseCharge();
     calculateLOL();
});

$('#estApproved').on('blur',function(){
     calculatePPCDIAG();
});

$('#remainingLOL').on('blur',function(){
     calculateLOL();
});

$('#modalCloseButton').on('click',function(){
     resetestForm();
});

$('#controlBar textarea').click(function(e) {
  e.stopPropagation();
});

$('#skuVerification').on('blur',function(){
     skuVerification();
});

$('#spCode').on('blur',function(){
     spVerification();
});

$('#warrantyExtension').on('click',function(){
     validateWarranty();
});

$('#limitLiability').on('blur',function(){
     rspCheckVal();
});

$('#modelNumber').on('blur',function(){
     $('#modelNumberSam').val($(this).val());
});

$('#serialNumber').on('blur',function(){
     $('#serialNumberSam').val($(this).val());
});

$('#samCheckButton').on('click',function(){
     $('#samModal').modal('show');
     samVal();
});

$(document).on('keyup',function(){
     alertBoxVal();
     alertBoxVal2();
});

$('#formSubmitButton').on('click', function() {
    otlVal();
})

$('#formSubmitButton2').on('click', function() {
    otlVal2();
})

$('#primaryButton').on('click',function(){
     $('#limitLiability').tooltip({trigger: 'manual'}).tooltip('hide')
     $('#remainingLOL').tooltip({trigger: 'manual'}).tooltip('hide')
     $('#limitLiability2').tooltip({trigger: 'manual'}).tooltip('hide')
     $('#remainingLOL2').tooltip({trigger: 'manual'}).tooltip('hide')
});

$('#secondaryButton').on('click',function(){
     $('#limitLiability').tooltip({trigger: 'manual'}).tooltip('hide')
     $('#remainingLOL').tooltip({trigger: 'manual'}).tooltip('hide')
     $('#limitLiability2').tooltip({trigger: 'manual'}).tooltip('hide')
     $('#remainingLOL2').tooltip({trigger: 'manual'}).tooltip('hide')     
});

//$('#formSubmitButton').on('click',function(){
//     submitForm();
//     $("#form1").submit();
//});

function alertBoxVal() {
  if ($('#lolAlert').hasClass("text-danger", true) || $('#rspAlert').hasClass("text-danger", true) || $('#mjcAlert').hasClass("text-danger", true) || $('#300Alert').hasClass("text-danger", true)) {
    $('#alertBoxButton').prop("disabled", false);
    $('#formSubmitButton').prop("disabled", true);
    $('#formSubmitButton').removeClass("bg-success").addClass("bg-warning");
    $('#alertBoxButton').removeClass("bg-light").addClass("bg-warning");
    $('#alertFAB').removeClass("bg-success").addClass("bg-danger");
  } else {
    $('#alertBoxButton').prop("disabled", true);
    $('#formSubmitButton').prop("disabled", false);
    $('#formSubmitButton').removeClass("bg-warning").addClass("bg-success");
    $('#alertBoxButton').removeClass("bg-warning").addClass("bg-light");
    $('#alertFAB').removeClass("bg-danger").addClass("bg-success");    
  }
};

function alertBoxOverride () {
    $('#alertBoxButton').prop("disabled", true);
    $('#formSubmitButton').prop("disabled", false);
    $('#formSubmitButton').removeClass("bg-warning").addClass("bg-success");
    $('#alertBoxButton').removeClass("bg-success").addClass("bg-light");
}

//SKU Verification
function skuVerification() {
    var triggerWords = ['MJC5', 'GMJC5', 'MJC10', 'MJC5-V', 'MJC10-NC', 'MJC210', 'D-MJC10', 'D-MJC210', 'MJR10', 'MJC5E', 'MJC5-NC', 'MJC8', 'MJC10-NL', 'NLMJC10', 'GMJC10', 'MJC10NLF', 'MJR5', 'RPL1U50', 'RPL1U100', 'RPL1U200', 'RPL1U300', 'RPL1U400', 'RPL1U500', 'RPL1U750', 'RPL1U1000', 'RPL2U50', 'RPL2U100', 'RPL2U200', 'RPL2U300', 'RPL2U400', 'RPL2U500', 'RPL2U1000'];
    for (var i = 0; i < triggerWords.length; i++) {
        if ($('#skuVerification').val().toUpperCase() == triggerWords[i]) {
            $('#mjcAlert').removeClass("fa-check-circle-o").addClass("fa-times-circle").addClass("text-danger");
            $('#overrideSubmitButton').prop( "disabled", false );
            alert('CHECK PLAN SKU BEFORE CONTINUING');
        }; 
      }; 
};

//Samsung Ice Maker Warranty
function samVal() {
  var modVal = $('#modelNumberSam').val();
  var serVal = $('#serialNumberSam').val();
  var aVal = a();
  function a() {
    var snArray = ['HC', 'J1', 'J2', 'J3', 'J4', 'J5', 'J6', 'J7', 'J8', 'J9'];
    for (var i = 0; i < snArray.length; i++) {
      if (modVal.toUpperCase().includes("RF", 0-2) == true) {
          $('#modAlert').addClass("bg-warning");
      };
      if (serVal.toUpperCase().includes(snArray[i], 5-7) == true) {
          $('#serAlert').addClass("bg-warning");  
          $('#samVerification').prop( "hidden", false );
          $('#overrideSP').prop( "disabled", false );
      };
    };
  };
  if (aVal = true) {
    $('#samWarning').prop( "hidden", false );
    $('#overrideSam').prop("disabled", false);
  } 
};


//SP Verification
function spVerification() {
    var triggerCodes = ['SP-NL-AMEX', 'S-SEAN-HIC'];
    for (var i = 0; i < triggerCodes.length; i++) {
        if ($('#spCode').val().toUpperCase() == triggerCodes[i] || $('#spCode').val().toUpperCase() == (" " + triggerCodes[i])) {
            alert('Credit Card Provider, fill out credit card tab');
            $('#overrideHeader').prop( "hidden", false );
            $('#overrideSPVis').prop( "hidden", false );
            $('#overrideSP').prop( "disabled", false );    
        }; 
      }; 
};

//Warranty Information display mirroring
$('.mirror').on('keyup', function(){
  $('.'+$(this).attr('class')).val($(this).val());
});

//Calculation Functions
function calculateLiabilities() {
	$('#limitLiability').val(
		(parseFloat($('#originalPrice').val() ? $('#originalPrice').val() : "0.00")
		-
		parseFloat($('#previousPaid').val() ? $('#previousPaid').val() : "0.00")).toFixed(2)
  )
  var txt = "";
  if ($('#limitLiability').val() < 300) {    
      $('#limitLiability').tooltip({trigger: 'manual'}).tooltip('show');
      $('#overrideWarranty').prop("disabled", false );
      $('#overrideWarrantyVis').prop( "hidden", false );
      $('#300Alert').removeClass("fa-check-circle-o").addClass("fa-times-circle").addClass("text-danger");
  } else {
      $('#limitLiability').tooltip({trigger: 'manual'}).tooltip('hide');
      $('#300Alert').removeClass("fa-times-circle").removeClass("text-danger").addClass("fa-check-circle-o");
  }
}

function rspCheckVal() {
  if ($('#rspButton').prop('checked') && $('#previousPaid').val() > 0) {
      $('#rspCheckField').prop( "hidden", false );          
      $('#rspCheck').val(
          (
          (((parseFloat($('#previousPaid').val() ? $('#previousPaid').val() : "0.00")
          +
          (250))
          *
          (100))
          /
          parseFloat($('#originalPrice').val() ? $('#originalPrice').val() : "0.00")
          )).toFixed(0)); 
    };
  if ($('#rspCheck').val() > 70) {
      $('#rspAlert').removeClass("fa-check-circle-o").addClass("fa-times-circle").addClass("text-danger");
  }   else {
    $('#rspAlert').removeClass("fa-times-circle").addClass("fa-times-check-o").removeClass("text-danger");
  };
};

function calculateExpenseCharge() {
	$('#totalEstimate').val(
		(
			(parseFloat($('#totalParts').val() ? $('#totalParts').val() : "0.00")
			+
			parseFloat($('#totalLabor').val() ? $('#totalLabor').val() : "0.00")
			+
			parseFloat($('#totalTax').val() ? $('#totalTax').val() : "0.00")
			+
			parseFloat($('#totalMileage').val() ? $('#totalMileage').val() : "0.00")
      +
      parseFloat($('#totalMisc').val() ? $('#totalMisc').val() : "0.00"))      
			-
			(parseFloat($('#totalDeductible').val() ? $('#totalDeductible').val() : "0.00"))
		).toFixed(2)
  );
  if ($('#rspButton').prop('checked') && $('#previousPaid').val() < 1) {
      $('#rspCheckField2').prop( "hidden", false );       
      $('#rspCheck2').val(
        (
          ((parseFloat($('#totalEstimate').val() ? $('#totalEstimate').val() : "0.00")
            *
            (100))
            /
            parseFloat($('#originalPrice').val() ? $('#originalPrice').val() : "0.00")
            )).toFixed(0))
    };     
  if ($('#rspCheck2').val() > 70) {
      $('#rspAlert').removeClass("fa-check-circle-o").addClass("fa-times-circle").addClass("text-danger");
    }   else {
      $('#rspAlert').removeClass("fa-times-circle").addClass("fa-check-circle-o").removeClass("text-danger");
    };       
};

function calculatePPCDIAG() {
  $('#ppcDIAG').val(
    (parseFloat($('#previousPaid').val() ? $('#previousPaid').val() : "0.00")
    +
    parseFloat($('#diagOnly').val() ? $('#diagOnly').val() : "0.00")).toFixed(2)
   ) 
}

function calculateLOL() {
  $('#remainingLOL').val(
    (parseFloat($('#limitLiability').val() ? $('#limitLiability').val() : "0.00")
    -
    parseFloat($('#totalEstimate').val() ? $('#totalEstimate').val() : "0.00")).toFixed(2)
  )
  var txt = "";
  if ($('#remainingLOL').val() < 0) {    
      $('#remainingLOL').tooltip({trigger: 'manual'}).tooltip('show');
      $('#lolAlert').removeClass("fa-check-circle-o").addClass("fa-times-circle").addClass("text-danger");
  } else {
      $('#remainingLOL').tooltip({trigger: 'manual'}).tooltip('hide');
      $('#lolAlert').removeClass("fa-times-circle").addClass("fa-check-circle-o").removeClass("text-danger");
  }
}

// FORM SUBMIT VALIDATION SECTION

function submitForm() {
  // Verify forms
  var formValidation = verifyForm();
  $('#limitLiability').tooltip({trigger: 'manual'}).tooltip('hide');
  $('#remainingLOL').tooltip({trigger: 'manual'}).tooltip('hide');
  if (formValidation) {
    // Populate #formReceipt with template.
    formReceiptTemplate();
    // Pop modal to display template info
    $('#formReceiptModal').modal('show');
  } else {
    $('#overrideModal').modal('show');
  }
}

function validateWarranty() {
  if (document.getElementById("warrantyExtension").checked) {
      $('#overrideWarranty').prop( "disabled", false );    
      $('#overrideWarrantyVis').prop( "hidden", false );
  } 
}

$(function() {
  enable_cb();
  $('#overrideRemLOL').click(enable_cb);
  $('#overrideWarranty').click(enable_cb);
  $('#overrideSP').click(enable_cb);
  $('#overrideSam').click(enable_cb);
});

function enable_cb() {
  if (this.checked) {
    $("#bypassModalCloseButton").removeAttr("disabled");
  } else {
    $("#bypassModalCloseButton").attr("disabled", true);
  }
}

function verifyForm() {
 if (document.getElementById("warrantyExtension").checked || $('#overrideHeader').prop('hidden') == false || $('#samVerification').prop('hidden') == false) {
  return false;
 } else {
  return true;
 };
};

function receiptModalBypass() {
    formReceiptTemplate();  
    $('#formReceiptModal').modal('show');
    $('#overrideWarranty').prop( "disabled", true );    
    $('#overrideWarrantyVis').prop( "hidden", true );  
    $('#overrideRemLOL').prop( "disabled", true );    
    $('#overrideRemLOLVis').prop( "hidden", true );      
}

$(document).ready(function () {
$('#estApproved').change(function() {
  if ( $('#estApproved').val() == "APPROVED") {
    $('#diagOnly').prop( "disabled", true );
  } else {
    $('#diagOnly').prop( "disabled", false );
    $('#diagOnly').prop( "required", true );
  } 
});
});

//Form Reset Functions

function resetestForm() {
    $('#estForm').trigger("reset")
    $('html, body').animate({
        scrollTop: $("#infoBlock").offset().top
    }, 800);
    $('#overrideRemLOL').prop("disabled", true );
    $('#overrideRemLOLVis').prop( "hidden", true );
    $('#overrideWarranty').prop("disabled", true );
    $('#overrideWarrantyVis').prop( "hidden", true ); 
    $('#bypassModalCloseButton').prop( "disabled", true );  
    $('#rspCheckField').prop( "hidden", true );  
    $('#rspCheckField2').prop( "hidden", true );   
    $('#300Alert').removeClass("text-danger").removeClass("fa-times-circle").addClass("fa-check-circle-o");
    $('#limitLiability').tooltip({trigger: 'manual'}).tooltip('hide');
    $('#remainingLOL').tooltip({trigger: 'manual'}).tooltip('hide');
    $('#rspAlert').removeClass("fa-times-circle").addClass("fa-check-circle-o").removeClass("text-danger");
    $('#mjcAlert').removeClass("fa-times-circle").addClass("fa-check-circle-o").removeClass("text-danger");
    $('#lolAlert').removeClass("fa-times-circle").addClass("fa-check-circle-o").removeClass("text-danger");
    $('#alertFAB').removeClass("bg-danger").addClass("bg-success"); 
    $('#alertBoxButton').removeClass("bg-success").addClass("bg-light");
    $('#overrideHeader').prop( "hidden", true );
    $('#overrideSP').prop( "disabled", true );
    $('#overrideSPVis').prop( "hidden", true );
    $('#modAlert').removeClass("bg-warning");
    $('#serAlert').removeClass("bg-warning");
    $('#samVerification').prop( "hidden", true );
    $('#overrideSam').prop("disabled", true);
}

function resetestFormButton() {
  $('#estForm').trigger("reset");
  $('#formSubmitButton').prop("disabled", false);
      $('html, body').animate({
        scrollTop: $("#infoBlock").offset().top
    }, 800);
  $('#overrideRemLOL').prop("disabled", true );
  $('#overrideRemLOLVis').prop( "hidden", true );
  $('#overrideWarranty').prop("disabled", true );
  $('#overrideWarrantyVis').prop( "hidden", true ); 
  $('#bypassModalCloseButton').prop( "disabled", true );  
  $('#rspCheckField').prop( "hidden", true );  
  $('#rspCheckField2').prop( "hidden", true );  
  $('#300Alert').removeClass("text-danger").removeClass("fa-times-circle").addClass("fa-check-circle-o");  
  $('#limitLiability').tooltip({trigger: 'manual'}).tooltip('hide');  
  $('#remainingLOL').tooltip({trigger: 'manual'}).tooltip('hide');
  $('#rspAlert').removeClass("fa-times-circle").addClass("fa-check-circle-o").removeClass("text-danger");    
  $('#mjcAlert').removeClass("fa-times-circle").addClass("fa-check-circle-o").removeClass("text-danger");
  $('#lolAlert').removeClass("fa-times-circle").addClass("fa-check-circle-o").removeClass("text-danger");
  $('#alertFAB').removeClass("bg-danger").addClass("bg-success");   
  $('#alertBoxButton').removeClass("bg-success").addClass("bg-light"); 
  $('#overrideHeader').prop( "hidden", true );
  $('#overrideWarranty').prop( "disabled", true );
  $('#overrideSPVis').prop( "hidden", true );
  $('#modAlert').removeClass("bg-warning");
  $('#serAlert').removeClass("bg-warning");  
  $('#samVerification').prop( "hidden", true );
  $('#overrideSam').prop("disabled", true);
}

//Generating Shortkey Functions

function formReceiptTemplate() {
  $('#formReceipt').val(
    Date() + ' '  + $('#soNumber').val()
    +'\n '
    +'\nName of s/p and person supplying estimate: '  + $('#callerName ').val() + ' @ ' + $('#serviceProvider').val()
    +'\nModel number: ' + $('#modelNumber').val()
    +'\nSerial number: ' + $('#serialNumber').val()
    +'\nCause of Failure: ' + $('#failureCause').val()
    +'\nManufacturer\'s Warranty Link: ' + $('#warrantyLink').val()
    +'\nPlan SKU: ' + $('#skuVerification').val()
    +'\n*If exception exists for this MFG refer service provider to the manufacturer if within exception period.* '
    +'\nOPP: $'+ $('#originalPrice').val() +' Previous Paid Claims: $'+ $('#previousPaid').val() +' Limit of Liability: $' + $('#limitLiability').val()
    +'\nWhere were part prices verified: ' + $('#partDistributor').val()
    +'\n'
    +'\n'
    +'\nTotal Parts: $'+ $('#totalParts').val() +' Labor: $'+ $('#totalLabor').val() +' Tax: $' + $('#totalTax').val()
    +'\nMileage: $' + $('#totalMileage').val() +' Misc: $'+ $('#totalMisc').val()
    +'\nDeductible (if applicable): $' + $('#totalDeductible').val()
    +'\nTotal Estimate: $' + $('#totalEstimate').val()
    +'\n___________________________'
    +'\nEstimate: ' + $('#estApproved').val()
    +'\nAttempted Repair or Diagnostic Fee if Pending: $' + $('#diagOnly').val()
    +'\nPre-Approval Code: '
    +'\n'
    +'\n"As a reminder, all pre-approvals are contingent upon verification of your contracted or agreed upon service rates. Contracted rates supersede preliminary estimates and approvals".'
    +'\n '
    +'\n '    
  );
  $('#formReceiptJFRR').val(
    + $('#soNumber').val()
    +'\n '    
    +'\nJustification for Replacement Review (why) :  '
    +'\nInitial purchase price of unit (OPP): '  + $('#originalPrice').val()
    +'\nAttempted Repair or Diagnostic Fee: ' + $('#diagOnly').val()
    +'\nTotal of all previous paid, pending and current owed clams: ' + $('#ppcDIAG').val()
    +'\n(If Diag was done please enter total amount of estimate here): ' + $('#totalEstimate').val()
    +'\nIs Proof of Purchase required? Yes _____        No _____'
    +'\nIf Yes make sure it been received'
    +'\nIf open SO was dispatched you will need to create Sub SO and assigned to Pending Review'
    +'\n '   
    +'\n--------------------------------------------------------------'    
    +'\n '     
  );
}

// Email over limits
$('#emailFormButton').on('click',function(){
     emailOTL();
});

function emailOTL() {
    $.ajax({
      url: 'validator_email',
      type: 'put',
      data: { 
        username: <%= current_user.full_name %>,
        receipt: $('#formReceipt').val(),
        caller_name: $('#callerName').val(), 
        service_provider: $('#serviceProvider').val(), 
        model_number: $('#modelNumber').val(), 
        serial_number: $('#serialNumber').val(), 
        failure_cause: $('#failureCause').val(), 
        warranty_link: $('#warrantyLink').val(), 
        sku: $('#skuVerification').val(), 
        opp: $('#originalPrice').val(), 
        ppc: $('#previousPaid').val(),
        lol: $('#limitLiability').val(),
        distributor: $('#partDistributor').val(),
        total_parts: $('#totalParts').val(),
        total_labor: $('#totalLabor').val(),
        total_tax: $('#totalTax').val(),
        total_mileage: $('#totalMileage').val(),
        total_misc: $('#totalMisc').val(),
        total_deductible: $('#totalDeductible').val(),
        total_estimate: $('#totalEstimate').val(),
        approved: $('#estApproved').val(),
        diagnostic: $('#diagOnly').val(),
        serviceorder: $('#soNumber').val() 
      }
    })
}

function otlVal() {
  if ($('#totalEstimate').val() > 849.99) {
    $('#emailFormButton').prop('hidden', false)
  } else {
    $('#emailFormButton').prop('hidden', true)
  }
}

//Clipboard Copy Functions

function copyToClipboard() {
    $('#formReceipt').select();
    document.execCommand("copy");
}

function copyToClipboardJFRR() {
    $('#formReceiptJFRR').select();
    document.execCommand("copy");
}

function copyToClipboardNotepad() {
    $('#formReceipt').select();
    document.execCommand("copy");
}

function copyToClipboardHistoryTicker() {
    $('#formReceipt').select();
    document.execCommand("copy");
}

//History Tab Function

function appendTemplate(){
    var pasteTime = document.getElementById("formReceipt").value;    
    document.getElementById("receiptHistory").value += pasteTime;
    var pasteTime3 = document.getElementById("formReceiptJFRR").value;    
    document.getElementById("receiptHistory").value += pasteTime3;
    
}

// SMOOTH GLIDE SECTION TRANSITIONS




// Keypress Event Listeners

$('#originalPrice2').on('blur',function(){
     calculateLiabilities2();
});

$('#previousPaid2').on('blur',function(){
     calculateLiabilities2();
});

$('#totalParts2').on('blur',function(){
     calculateExpenseCharge2();
     calculateLOL2();
});

$('#totalLabor2').on('blur',function(){
     calculateExpenseCharge2();
     calculateLOL2();
});

$('#totalTax2').on('blur',function(){
     calculateExpenseCharge2();
     calculateLOL2();
});

$('#totalMileage2').on('blur',function(){
     calculateExpenseCharge2();
     calculateLOL2();
});

$('#totalMisc2').on('blur',function(){
     calculateExpenseCharge2();
     calculateLOL2();
});

$('#totalDeductible2').on('blur',function(){
     calculateExpenseCharge2();
     calculateLOL2();
});

$('#estApproved2').on('blur',function(){
     calculatePPCDIAG2();
});

$('#remainingLOL2').on('blur',function(){
     calculateLOL2();
});

$('#modalCloseButton2').on('click',function(){
     resetestForm2();
});

$('#controlBar2 textarea').click(function(e) {
  e.stopPropagation2();
});

$('#skuVerification2').on('blur',function(){
     skuVerification2();
});

$('#spCode2').on('blur',function(){
     spVerification2();
});

$('#warrantyExtension2').on('click',function(){
     validateWarranty2();
});

$('#limitLiability2').on('blur',function(){
     rspCheckVal2();
});

$('#modelNumber2').on('blur',function(){
     $('#modelNumberSam2').val($(this).val());
});

$('#serialNumber2').on('blur',function(){
     $('#serialNumberSam2').val($(this).val());
});

$('#samCheckButton2').on('click',function(){
     $('#samModal2').modal('show');
     samVal2();
});

function alertBoxVal2() {
  if ($('#lolAlert2').hasClass("text-danger", true) || $('#rspAlert2').hasClass("text-danger", true) || $('#mjcAlert2').hasClass("text-danger", true) || $('#300Alert2').hasClass("text-danger", true)) {
    $('#alertBoxButton2').prop("disabled", false);
    $('#formSubmitButton2').prop("disabled", true);
    $('#formSubmitButton2').removeClass("bg-success").addClass("bg-warning");
    $('#alertBoxButton2').removeClass("bg-light").addClass("bg-warning");
    $('#alertFAB2').removeClass("bg-success").addClass("bg-danger");
  } else {
    $('#alertBoxButton2').prop("disabled", true);
    $('#formSubmitButton2').prop("disabled", false);
    $('#formSubmitButton2').removeClass("bg-warning").addClass("bg-success");
    $('#alertBoxButton2').removeClass("bg-warning").addClass("bg-light");
    $('#alertFAB2').removeClass("bg-danger").addClass("bg-success");    
  }
};

function alertBoxOverride2 () {
    $('#alertBoxButton2').prop("disabled", true);
    $('#formSubmitButton2').prop("disabled", false);
    $('#formSubmitButton2').removeClass("bg-warning").addClass("bg-success");
    $('#alertBoxButton2').removeClass("bg-success").addClass("bg-light");
}

//SKU Verification
function skuVerification2() {
    var triggerWords2 = ['MJC5', 'GMJC5', 'MJC10', 'MJC5-V', 'MJC10-NC', 'MJC210', 'D-MJC10', 'D-MJC210', 'MJR10', 'MJC5E', 'MJC5-NC', 'MJC8', 'MJC10-NL', 'NLMJC10', 'GMJC10', 'MJC10NLF', 'MJR5', 'RPL1U50', 'RPL1U100', 'RPL1U200', 'RPL1U300', 'RPL1U400', 'RPL1U500', 'RPL1U750', 'RPL1U1000', 'RPL2U50', 'RPL2U100', 'RPL2U200', 'RPL2U300', 'RPL2U400', 'RPL2U500', 'RPL2U1000'];
    for (var i = 0; i < triggerWords2.length; i++) {
        if ($('#skuVerification2').val().toUpperCase() == triggerWords2[i]) {
            $('#mjcAlert2').removeClass("fa-check-circle-o").addClass("fa-times-circle").addClass("text-danger");
            $('#overrideSubmitButton2').prop( "disabled", false );
            alert('CHECK PLAN SKU BEFORE CONTINUING');
        } 
      } 
}

//Samsung Ice Maker Warranty
function samVal2() {
  var modVal2 = $('#modelNumberSam2').val();
  var serVal2 = $('#serialNumberSam2').val();
  var aVal2 = a2();
  function a2() {
    var snArray2 = ['HC', 'J1', 'J2', 'J3', 'J4', 'J5', 'J6', 'J7', 'J8', 'J9'];
    for (var i = 0; i < snArray2.length; i++) {
      if (modVal2.toUpperCase().includes("RF", 0-2) == true) {
          $('#modAlert2').addClass("bg-warning");
      };
      if (serVal2.toUpperCase().includes(snArray2[i], 5-7) == true) {
          $('#serAlert2').addClass("bg-warning"); 
          $('#samVerification2').prop( "hidden", false );
          $('#overrideSP2').prop( "disabled", false ); 
      };
    };
  };
  if (aVal2 = true) {
    $('#samWarning2').prop( "hidden", false );
    $('#overrideSam2').prop("disabled", false);
  } 
};

//SP Verification
function spVerification2() {
    var triggerCodes2 = ['SP-NL-AMEX', 'S-SEAN-HIC'];
    for (var i = 0; i < triggerCodes2.length; i++) {
        if ($('#spCode2').val().toUpperCase() == triggerCodes2[i]) {
            alert('Credit Card Provider, fill out credit card tab');
            $('#overrideHeader2').prop( "hidden", false );
            $('#overrideSPVis2').prop( "hidden", false );
            $('#overrideSP2').prop( "disabled", false );  
        }; 
      }; 
};

//Warranty Information display mirroring
$('.mirror2').on('keyup', function(){
  $('.'+$(this).attr('class')).val($(this).val());
});

//Warranty Information display mirroring
$('.mirror3').on('keyup', function(){
  $('.'+$(this).attr('class')).val($(this).val());
});

//Calculation Functions
function calculateLiabilities2() {
  $('#limitLiability2').val(
    (parseFloat($('#originalPrice2').val() ? $('#originalPrice2').val() : "0.00")
    -
    parseFloat($('#previousPaid2').val() ? $('#previousPaid2').val() : "0.00")).toFixed(2)
  )
  var txt = "";
  if ($('#limitLiability2').val() < 300) {    
      $('#limitLiability2').tooltip({trigger: 'manual'}).tooltip('show');
      $('#overrideWarranty2').prop("disabled", false );
      $('#overrideWarrantyVis2').prop( "hidden", false );
      $('#300Alert2').removeClass("fa-check-circle-o").addClass("fa-times-circle").addClass("text-danger");
  } else {
      $('#limitLiability2').tooltip({trigger: 'manual'}).tooltip('hide')
      $('#300Alert2').removeClass("fa-times-circle").removeClass("text-danger").addClass("fa-check-circle-o");
  }
}

function rspCheckVal2() {
  if ($('#rspButton2').prop('checked') && $('#previousPaid2').val() > 0) {
      $('#rspCheckField3').prop( "hidden", false );          
      $('#rspCheck3').val(
          (
          (((parseFloat($('#previousPaid2').val() ? $('#previousPaid2').val() : "0.00")
          +
          (250))
          *
          (100))
          /
          parseFloat($('#originalPrice2').val() ? $('#originalPrice2').val() : "0.00")
          )).toFixed(0)); 
    };
  if ($('#rspCheck2').val() > 70) {
      $('#rspAlert2').removeClass("fa-check-circle-o").addClass("fa-times-circle").addClass("text-danger");
  }   else {
    $('#rspAlert2').removeClass("fa-times-circle").addClass("fa-times-check-o").removeClass("text-danger");
  };    
};

function calculateExpenseCharge2() {
  $('#totalEstimate2').val(
    (
      (parseFloat($('#totalParts2').val() ? $('#totalParts2').val() : "0.00")
      +
      parseFloat($('#totalLabor2').val() ? $('#totalLabor2').val() : "0.00")
      +
      parseFloat($('#totalTax2').val() ? $('#totalTax2').val() : "0.00")
      +
      parseFloat($('#totalMileage2').val() ? $('#totalMileage2').val() : "0.00")
      +
      parseFloat($('#totalMisc2').val() ? $('#totalMisc2').val() : "0.00"))      
      -
      (parseFloat($('#totalDeductible2').val() ? $('#totalDeductible2').val() : "0.00"))
    ).toFixed(2)
  );
  if ($('#rspButton2').prop('checked') && $('#previousPaid2').val() < 1) {
      $('#rspCheckField4').prop( "hidden", false );       
      $('#rspCheck4').val(
        (
          ((parseFloat($('#totalEstimate2').val() ? $('#totalEstimate2').val() : "0.00")
            *
            (100))
            /
            parseFloat($('#originalPrice2').val() ? $('#originalPrice2').val() : "0.00")
            )).toFixed(0))
    };    
  if ($('#rspCheck4').val() > 70) {
      $('#rspAlert2').removeClass("fa-check-circle-o").addClass("fa-times-circle").addClass("text-danger");
    }   else {
      $('#rspAlert2').removeClass("fa-times-circle").addClass("fa-check-circle-o").removeClass("text-danger");
    };            
};

function calculatePPCDIAG2() {
  $('#ppcDIAG2').val(
    (parseFloat($('#previousPaid2').val() ? $('#previousPaid2').val() : "0.00")
    +
    parseFloat($('#diagOnly2').val() ? $('#diagOnly2').val() : "0.00")).toFixed(2)
   ) 
}

function calculateLOL2() {
  $('#remainingLOL2').val(
    (parseFloat($('#limitLiability2').val() ? $('#limitLiability2').val() : "0.00")
    -
    parseFloat($('#totalEstimate2').val() ? $('#totalEstimate2').val() : "0.00")).toFixed(2)
  )
  var txt = "";
  if ($('#remainingLOL2').val() < 0) {    
      $('#remainingLOL2').tooltip({trigger: 'manual'}).tooltip('show');
      $('#lolAlert2').removeClass("fa-check-circle-o").addClass("fa-times-circle").addClass("text-danger");
  } else {
      $('#remainingLOL2').tooltip({trigger: 'manual'}).tooltip('hide')
      $('#lolAlert2').removeClass("fa-times-circle").addClass("fa-check-circle-o").removeClass("text-danger");
  }
}

// FORM SUBMIT VALIDATION SECTION

function submitForm2() {
  // Verify forms
  var formValidation2 = verifyForm2();
  $('#limitLiability2').tooltip({trigger: 'manual'}).tooltip('hide');
  $('#remainingLOL2').tooltip({trigger: 'manual'}).tooltip('hide');
  if (formValidation2) {
    // Populate #formReceipt with template.
    formReceiptTemplate2();
    // Pop modal to display template info
    $('#formReceiptModal2').modal('show');
  } else {
    $('#overrideModal2').modal('show');
  }
}

function validateWarranty2() {
  if (document.getElementById("warrantyExtension2").checked) {
      $('#overrideWarranty2').prop( "disabled", false );    
      $('#overrideWarrantyVis2').prop( "hidden", false );
  } 
}

$(function() {
  enable_cb2();
  $('#overrideRemLOL2').click(enable_cb2);
  $('#overrideWarranty2').click(enable_cb2);
  $('#overrideSP2').click(enable_cb2); 
  $('#overrideSam2').click(enable_cb2); 
});

function enable_cb2() {
  if (this.checked) {
    $("#bypassModalCloseButton2").removeAttr("disabled");
  } else {
    $("#bypassModalCloseButton2").attr("disabled", true);
  }
}

function verifyForm2() {
 if (document.getElementById("warrantyExtension2").checked || $('#overrideHeader2').prop('hidden') == false || $('#samVerification2').prop('hidden') == false) {
  return false;
 } else {
  return true;
 };
};

function receiptModalBypass2() {
    formReceiptTemplate2();  
    $('#formReceiptModal2').modal('show');
    $('#overrideWarranty2').prop( "disabled", true );    
    $('#overrideWarrantyVis2').prop( "hidden", true );  
    $('#overrideRemLOL2').prop( "disabled", true );    
    $('#overrideRemLOLVis2').prop( "hidden", true );      
}

$(document).ready(function () {
$('#estApproved2').change(function() {
  if ( $('#estApproved2').val() == "APPROVED") {
    $('#diagOnly2').prop( "disabled", true );
  } else {
    $('#diagOnly2').prop( "disabled", false );
    $('#diagOnly2').prop( "required", true );
  } 
});
});

//Form Reset Functions

function resetestForm2() {
    $('#estForm2').trigger("reset")
    $('html, body').animate({
        scrollTop: $("#infoBlock2").offset().top
    }, 800);
    $('#overrideRemLOL2').prop("disabled", true );
    $('#overrideRemLOLVis2').prop( "hidden", true );
    $('#overrideWarranty2').prop("disabled", true );
    $('#overrideWarrantyVis2').prop( "hidden", true ); 
    $('#bypassModalCloseButton2').prop( "disabled", true );
    $('#rspCheckField3').prop( "hidden", true );  
    $('#rspCheckField4').prop( "hidden", true );           
    $('#300Alert2').removeClass("text-danger").removeClass("fa-times-circle").addClass("fa-check-circle-o");
    $('#limitLiability2').tooltip({trigger: 'manual'}).tooltip('hide');
    $('#remainingLOL2').tooltip({trigger: 'manual'}).tooltip('hide');
    $('#rspAlert2').removeClass("fa-times-circle").addClass("fa-check-circle-o").removeClass("text-danger");
    $('#mjcAlert2').removeClass("fa-times-circle").addClass("fa-check-circle-o").removeClass("text-danger");
    $('#lolAlert2').removeClass("fa-times-circle").addClass("fa-check-circle-o").removeClass("text-danger");
    $('#alertFAB2').removeClass("bg-danger").addClass("bg-success"); 
    $('#alertBoxButton2').removeClass("bg-success").addClass("bg-light");
    $('#overrideHeader2').prop( "hidden", true );
    $('#overrideWarranty2').prop( "disabled", true );
    $('#overrideSPVis2').prop( "hidden", true );    
    $('#modAlert2').removeClass("bg-warning");
    $('#serAlert2').removeClass("bg-warning"); 
    $('#samVerification2').prop( "hidden", true );
    $('#overrideSam2').prop("disabled", true);   
}

function resetSetForm() {
  $('#setForm').trigger("reset");
};

function resetestFormButton2() {
  $('#estForm2').trigger("reset");
  $('#formSubmitButton2').prop("disabled", false);
      $('html, body').animate({
        scrollTop: $("#infoBlock2").offset().top
    }, 800);
  $('#overrideRemLOL2').prop("disabled", true );
  $('#overrideRemLOLVis2').prop( "hidden", true );
  $('#overrideWarranty2').prop("disabled", true );
  $('#overrideWarrantyVis2').prop( "hidden", true ); 
  $('#bypassModalCloseButton2').prop( "disabled", true );
  $('#rspCheckField3').prop( "hidden", true );  
  $('#rspCheckField4').prop( "hidden", true );   
  $('#300Alert2').removeClass("text-danger").removeClass("fa-times-circle").addClass("fa-check-circle-o");  
  $('#limitLiability2').tooltip({trigger: 'manual'}).tooltip('hide');  
  $('#remainingLOL2').tooltip({trigger: 'manual'}).tooltip('hide');
  $('#rspAlert2').removeClass("fa-times-circle").addClass("fa-check-circle-o").removeClass("text-danger");    
  $('#mjcAlert2').removeClass("fa-times-circle").addClass("fa-check-circle-o").removeClass("text-danger");
  $('#lolAlert2').removeClass("fa-times-circle").addClass("fa-check-circle-o").removeClass("text-danger");
  $('#alertFAB2').removeClass("bg-danger").addClass("bg-success");   
  $('#alertBoxButton2').removeClass("bg-success").addClass("bg-light"); 
  $('#overrideHeader2').prop( "hidden", true );
  $('#overrideWarranty2').prop( "disabled", true );
  $('#overrideSPVis2').prop( "hidden", true ); 
  $('#modAlert2').removeClass("bg-warning");
  $('#serAlert2').removeClass("bg-warning");  
  $('#samVerification2').prop( "hidden", true );
  $('#overrideSam2').prop("disabled", true);
}

//Generating Shortkey Functions

function formReceiptTemplate2() {
  $('#formReceipt2').val(
    '\n '
    +Date() + ' '  + $('#soNumber2').val()
    +'\n '
    +'\nName of s/p and person supplying estimate: '  + $('#callerName2 ').val() + ' @ ' + $('#serviceProvider2').val()
    +'\nModel number: ' + $('#modelNumber2').val()
    +'\nSerial number: ' + $('#serialNumber2').val()
    +'\nCause of Failure: ' + $('#failureCause2').val()
    +'\nManufacturer\'s Warranty Link: ' + $('#warrantyLink2').val()
    +'\nPlan SKU: ' + $('#skuVerification2').val()
    +'\n*If exception exists for this MFG refer service provider to the manufacturer if within exception period.* '
    +'\nOPP: $'+ $('#originalPrice2').val() +' Previous Paid Claims: $'+ $('#previousPaid2').val() +' Limit of Liability: $' + $('#limitLiability2').val()
    +'\nWhere were part prices verified: ' + $('#partDistributor2').val()
    +'\n'
    +'\n'
    +'\nTotal Parts: $'+ $('#totalParts2').val() +' Labor: $'+ $('#totalLabor2').val() +' Tax: $' + $('#totalTax2').val()
    +'\nMileage: $' + $('#totalMileage2').val() +' Misc: $'+ $('#totalMisc2').val()
    +'\nDeductible (if applicable): $' + $('#totalDeductible2').val()
    +'\nTotal Estimate: $' + $('#totalEstimate2').val()
    +'\n___________________________'
    +'\nEstimate: ' + $('#estApproved2').val()
    +'\nAttempted Repair or Diagnostic Fee if Pending: $' + $('#diagOnly2').val()
    +'\nPre-Approval Code: '
    +'\n'
    +'\n"As a reminder, all pre-approvals are contingent upon verification of your contracted or agreed upon service rates. Contracted rates supersede preliminary estimates and approvals".'
    +'\n '
    +'\n '    
  );
  $('#formReceiptJFRR2').val(
    '\n '
    + $('#soNumber2').val()
    +'\n '    
    +'\nJustification for Replacement Review (why) :  '
    +'\nInitial purchase price of unit (OPP): '  + $('#originalPrice2').val()
    +'\nAttempted Repair or Diagnostic Fee: ' + $('#diagOnly2').val()
    +'\nTotal of all previous paid, pending and current owed clams: ' + $('#ppcDIAG2').val()
    +'\n(If Diag was done please enter total amount of estimate here): ' + $('#totalEstimate2').val()
    +'\nIs Proof of Purchase required? Yes _____        No _____'
    +'\nIf Yes make sure it been received'
    +'\nIf open SO was dispatched you will need to create Sub SO and assigned to Pending Review'
    +'\n '    
    +'\n--------------------------------------------------------------' 
    +'\n '    
  );
}

// Email over limits
$('#emailFormButton2').on('click',function(){
     emailOTL2();
});

function emailOTL2() {
    $.ajax({
      url: 'validator_email',
      type: 'put',
      data: { 
        username: <%= current_user.full_name %>,
        receipt: $('#formReceipt2').val(),
        caller_name: $('#callerName2').val(), 
        service_provider: $('#serviceProvider2').val(), 
        model_number: $('#modelNumber2').val(), 
        serial_number: $('#serialNumber2').val(), 
        failure_cause: $('#failureCause2').val(), 
        warranty_link: $('#warrantyLink2').val(), 
        sku: $('#skuVerification2').val(), 
        opp: $('#originalPrice2').val(), 
        ppc: $('#previousPaid2').val(),
        lol: $('#limitLiability2').val(),
        distributor: $('#partDistributor2').val(),
        total_parts: $('#totalParts2').val(),
        total_labor: $('#totalLabor2').val(),
        total_tax: $('#totalTax2').val(),
        total_mileage: $('#totalMileage2').val(),
        total_misc: $('#totalMisc2').val(),
        total_deductible: $('#totalDeductible2').val(),
        total_estimate: $('#totalEstimate2').val(),
        approved: $('#estApproved2').val(),
        diagnostic: $('#diagOnly2').val(),
        serviceorder: $('#soNumber2').val() 
      }
    })
}

function otlVal2() {
  if ($('#totalEstimate2').val() > 849.99) {
    $('#emailFormButton2').prop('hidden', false)
  } else {
    $('#emailFormButton2').prop('hidden', true)
  }
}

//Clipboard Copy Functions

function copyToClipboard2() {
    $('#formReceipt2').select();
    document.execCommand("copy");
}

function copyToClipboardJFRR2() {
    $('#formReceiptJFRR2').select();
    document.execCommand("copy");
}

function copyToClipboardNotepad2() {
    $('#formReceipt2').select();
    document.execCommand("copy");
}

function copyToClipboardHistoryTicker2() {
    $('#formReceipt2').select();
    document.execCommand("copy");
}

//History Tab Function

function appendTemplate2(){
    var pasteTime2 = document.getElementById("formReceipt2").value;    
    document.getElementById("receiptHistory").value += pasteTime2;
    var pasteTime4 = document.getElementById("formReceiptJFRR2").value;    
    document.getElementById("receiptHistory").value += pasteTime4;
    
}

;
