// Prevent enter from form submission
$("#callsForm").submit(function(e){ 
        e.preventDefault();
    });

// Event listeners
$('#shortkeyReset').on('click',function(){
     resetShortkey()
});

$('#spCodeCalls').on('blur',function(){
     spVerification()
});

$('#skuFieldCalls').on('blur',function(){
	$('#skuAlertCalls').removeClass("alert-calls");
     skuVerification()
});

$('#ppcFieldCalls').on('blur',function(){
     calculateLiabilities();
});

$('#oppFieldCalls').on('change',function(){
     calculateLiabilities();
     calculateTotal();
});

$('#ppcFieldCalls').on('change',function(){
     calculateLiabilities();
     calculateTotal();
});

$('#partsFieldCalls').on('blur',function(){
     calculateTotal();
});

$('#laborFieldCalls').on('blur',function(){
     calculateTotal();
});

$('#taxFieldCalls').on('blur',function(){
     calculateTotal();
});

$('#mileageFieldCalls').on('blur',function(){
     calculateTotal();
});

$('#miscFieldCalls').on('blur',function(){
     calculateTotal();
});

$('#deductibleFieldCalls').on('blur',function(){
     calculateTotal();
});

$('#totalFieldCalls').on('blur',function(){
     calculateTotal();
});

$('#totalLolFieldCalls').on('blur',function(){
     calculateTotal();
});

$('#attemptFieldCalls').on('blur',function(){
     calculateTotal();
     calculateJfrrRemainder();
});

$('#approvalSelectCalls').on('change', function(){
	approvalToggle();
})

$('#rspCheckCalls').on('click', function(){
	calculateTotal();
	calculateLiabilities();
})

$('#alertVerifiedCalls').on('click',function(){
    if ($('.collapse').hasClass('show')) {
    	alert('Please acknowledge all alerts first');
    } else {
	   	$('#alertModalCalls').modal('hide');
	    formReceiptTemplate();
	    otlVal();
	    $('#completionModalCalls').modal('show');
    };
});

$('#extCheckCalls').on('click',function(){
    if ($('#extCheckCalls').prop('checked') == true) {
    	$('#extensionModalCalls').modal('show');
    	$('.mirror').on('keyup', function(){
  			$('.mirror').val($(this).val());
		});
		$('#extAlertCalls').addClass('alert-calls');
		$('#extCollapse').addClass('show');
	} else {
		$('#extCollapse').removeClass('show');
		$('#extAlertCalls').removeClass('alert-calls');
	}
});

$('#samCheckCalls').on('click', function(){
	$('#modelNumberCalls').removeClass("alert-calls bg-warning");
	$('#serialNumberCalls').removeClass("alert-calls bg-warning");
	samVal();
})

// Reset shortkeys
function resetShortkey() {
	$('#shortkeyForm').trigger('reset');
}

// Reset button
$('#resetCalls').on('click', function(){
	$('#callsForm').trigger('reset');
	$('.alert-calls').removeClass('alert-calls bg-warning').addClass('text-muted');
  $('#est1ReceiptCallsJetsons').prop('hidden', true);
  $('#est1ReceiptCalls').prop('hidden', false);
})

// Email over limits
$('#emailFormButtonCalls').on('click',function(){
     emailOTL();
     $('#emailFormButtonCalls').prop('disabled', true);
     $('#emailFormButtonCalls').html("SENT");
});

// OTL ajax and such
function emailOTL() {
    $.ajax({
      url: 'validator_email',
      type: 'put',
      data: { 
        username: $('#username').val(),
        receipt: $('#est1ReceiptCalls').val(),
        caller_name: $('#callerNameCalls').val(), 
        service_provider: $('#servicerNameCalls').val(), 
        model_number: $('#modelNumberCalls').val(), 
        serial_number: $('#serialNumberCalls').val(), 
        failure_cause: $('#failureCauseCalls').val(), 
        warranty_link: $('#warrantyLinkCalls').val(), 
        sku: $('#skuFieldCalls').val(), 
        opp: $('#oppFieldCalls').val(), 
        ppc: $('#ppcFieldCalls').val(),
        lol: $('#lolFieldCalls').val(),
        distributor: $('#distributorFieldCalls').val(),
        total_parts: $('#partsFieldCalls').val(),
        total_labor: $('#laborFieldCalls').val(),
        total_tax: $('#taxFieldCalls').val(),
        total_mileage: $('#mileageFieldCalls').val(),
        total_misc: $('#miscFieldCalls').val(),
        total_deductible: $('#deductibleFieldCalls').val(),
        total_estimate: $('#totalFieldCalls').val(),
        approved: $('#approvalSelectCalls').val(),
        diagnostic: $('#attemptFieldCalls').val(),
        serviceorder: $('#soNumberCalls').val() 
      }
    })
}

function otlVal() {
  if ($('#totalFieldCalls').val() > 849.99) {
    $('#emailFormButtonCalls').prop('hidden', false);
    $('#emailFormButtonCalls').prop('disabled', false);
  } else {
    $('#emailFormButtonCalls').prop('hidden', true);
    $('#emailFormButtonCalls').prop('disabled', true);

  }
}

// Samsung model/serial verification to see if it lands under the ice maker warranty
function samVal() {
	var modVal = $('#modelNumberCalls').val();
	var serVal = $('#serialNumberCalls').val();
	var aVal = a();
	function a() {
    	var snArray = ['HC', 'J1', 'J2', 'J3', 'J4', 'J5', 'J6', 'J7', 'J8', 'J9'];
    	for (var i = 0; i < snArray.length; i++) {
    		if ((serVal.toUpperCase().includes(snArray[i], 5) == true) && (modVal.toUpperCase().includes("RF", 0) == true)) {
        		$('#modelNumberCalls').addClass("alert-calls");
            $('#serialNumberCalls').addClass("alert-calls"); 
        		$('#samAlertCalls').addClass("alert-calls");
            	$('#samCollapse').addClass('show'); 
    		};
    	};
	};
};

//SKU Verification
function skuVerification() {
    var triggerWords = ['MJC5', 'GMJC5', 'MJC10', 'MJC5-V', 'MJC10-NC', 'MJC210', 'D-MJC10', 'D-MJC210', 'MJR10', 'MJC5E', 'MJC5-NC', 'MJC8', 'MJC10-NL', 'NLMJC10', 'GMJC10', 'MJC10NLF', 'MJR5', 'RPL1U50', 'RPL1U100', 'RPL1U200', 'RPL1U300', 'RPL1U400', 'RPL1U500', 'RPL1U750', 'RPL1U1000', 'RPL2U50', 'RPL2U100', 'RPL2U200', 'RPL2U300', 'RPL2U400', 'RPL2U500', 'RPL2U1000'];
    for (var i = 0; i < triggerWords.length; i++) {
        if ($('#skuFieldCalls').val().toUpperCase() == triggerWords[i]) {
            $('#skuAlertCalls').addClass("alert-calls");
            $('#skuCollapse').addClass('show');
        }
    }; 
};

//SP Verification
function spVerification() {
    var triggerCodes = ['SP-NL-AMEX', 'S-SEAN-HIC'];
    var jetsonCode = 'S-1004-JET';
    for (var i = 0; i < triggerCodes.length; i++) {
        if ($('#spCodeCalls').val().toUpperCase() == triggerCodes[i] || $('#spCodeCalls').val().toUpperCase() == (" " + triggerCodes[i])) {
            alert('Credit Card Provider, fill out credit card tab'); 
        } else if ($('#spCodeCalls').val().toUpperCase() == jetsonCode || $('#spCodeCalls').val().toUpperCase() == (" " + jetsonCode)) {
        	$('#est1ReceiptCallsJetsons').prop('hidden', false);
        	$('#est1ReceiptCalls').prop('hidden', true);
        } else {
        	$('#est1ReceiptCallsJetsons').prop('hidden', true);
        	$('#est1ReceiptCalls').prop('hidden', false);
        }
	}; 
};

// Limit of Liability calculations "calculateLiabilities" & "calculateTotal"
function calculateLiabilities() {
	if ($('#rspCheckCalls').prop('checked') && $('#ppcFieldCalls').val() > 0) {
		$('#lolFieldCalls').val(
			(parseFloat($('#oppFieldCalls').val() ? $('#oppFieldCalls').val() : "0.00")
			-
			parseFloat($('#ppcFieldCalls').val() ? $('#ppcFieldCalls').val() : "0.00")
			-
			250).toFixed(2)
		);
		if ($('#lolFieldCalls').val() <= 0) {
			$('#lolAlertCalls').addClass('alert-calls');
			$('#lolCollapse').addClass('show');
		} else {
			$('#lolAlertCalls').removeClass('alert-calls');
			$('#lolCollapse').removeClass('show');
		}
		$('#lolPercFieldCalls').val(
			(parseFloat($('#lolFieldCalls').val() ? $('#lolFieldCalls').val() : "0.00")
			*
			100
			/
			parseFloat($('#oppFieldCalls').val() ? $('#oppFieldCalls').val() : "0.00")).toFixed(1)
		);
		if ($('#lolPercFieldCalls').val() < 30) {
			$('#rspAlertCalls').removeClass('text-muted').addClass('alert-calls');
			$('#rspCollapse').addClass('show');
			$('#lolPercFieldCalls').removeClass('text-muted').addClass('alert-calls bg-warning');
		} else {
			$('#rspAlertCalls').removeClass('alert-calls').addClass('text-muted');
			$('#rspCollapse').removeClass('show');
			$('#lolPercFieldCalls').removeClass('alert-calls bg-warning').addClass('text-muted');
		}
	}
	else {
		$('#lolFieldCalls').val(
			(parseFloat($('#oppFieldCalls').val() ? $('#oppFieldCalls').val() : "0.00")
			-
			parseFloat($('#ppcFieldCalls').val() ? $('#ppcFieldCalls').val() : "0.00")).toFixed(2)
		);
		$('#lolPercFieldCalls').val(
			(parseFloat($('#lolFieldCalls').val() ? $('#lolFieldCalls').val() : "0.00")
			*
			100
			/
			parseFloat($('#oppFieldCalls').val() ? $('#oppFieldCalls').val() : "0.00")).toFixed(1)
		);
		if ($('#lolFieldCalls').val() <= 300) {
			$('#300AlertCalls').addClass('alert-calls');
			$('#300Collapse').addClass('show');
		} else {
			$('#300AlertCalls').removeClass('alert-calls');
			$('#300Collapse').removeClass('show');
		}
	};
};

function calculateTotal() {
	if ($('#rspCheckCalls').prop('checked') && $('#ppcFieldCalls').val() == 0) {
		$('#totalFieldCalls').val(
			(parseFloat($('#partsFieldCalls').val() ? $('#partsFieldCalls').val() : "0.00")
			+
			parseFloat($('#laborFieldCalls').val() ? $('#laborFieldCalls').val() : "0.00")
			+
			parseFloat($('#taxFieldCalls').val() ? $('#taxFieldCalls').val() : "0.00")
			+
			parseFloat($('#mileageFieldCalls').val() ? $('#mileageFieldCalls').val() : "0.00")
			+
			parseFloat($('#miscFieldCalls').val() ? $('#miscFieldCalls').val() : "0.00")
			-
			parseFloat($('#deductibleFieldCalls').val() ? $('#deductibleFieldCalls').val() : "0.00")).toFixed(2)
		);
		$('#totalLolFieldCalls').val(
			(parseFloat($('#lolFieldCalls').val() ? $('#lolFieldCalls').val() : "0.00")
			-
			parseFloat($('#totalFieldCalls').val() ? $('#totalFieldCalls').val() : "0.00")).toFixed(2)
		)
		$('#totalLolPercFieldCalls').val(
			(parseFloat($('#totalLolFieldCalls').val() ? $('#totalLolFieldCalls').val() : "0.00")
			*
			100
			/
			parseFloat($('#oppFieldCalls').val() ? $('#oppFieldCalls').val() : "0.00")).toFixed(1)
		);
		if ($('#totalLolPercFieldCalls').val() < 30) {
			$('#rspAlertCalls').removeClass('text-muted').addClass('alert-calls');
			$('#totalLolPercFieldCalls').removeClass('text-muted').addClass('alert-calls bg-warning');
		}
	}
	else {
		$('#totalFieldCalls').val(
			(parseFloat($('#partsFieldCalls').val() ? $('#partsFieldCalls').val() : "0.00")
			+
			parseFloat($('#laborFieldCalls').val() ? $('#laborFieldCalls').val() : "0.00")
			+
			parseFloat($('#taxFieldCalls').val() ? $('#taxFieldCalls').val() : "0.00")
			+
			parseFloat($('#mileageFieldCalls').val() ? $('#mileageFieldCalls').val() : "0.00")
			+
			parseFloat($('#miscFieldCalls').val() ? $('#miscFieldCalls').val() : "0.00")
			-
			parseFloat($('#deductibleFieldCalls').val() ? $('#deductibleFieldCalls').val() : "0.00")).toFixed(2)
		);
		$('#totalLolFieldCalls').val(
			(parseFloat($('#lolFieldCalls').val() ? $('#lolFieldCalls').val() : "0.00")
			-
			parseFloat($('#totalFieldCalls').val() ? $('#totalFieldCalls').val() : "0.00")).toFixed(2)
		)
		$('#totalLolPercFieldCalls').val(
			(parseFloat($('#totalLolFieldCalls').val() ? $('#totalLolFieldCalls').val() : "0.00")
			*
			100
			/
			parseFloat($('#oppFieldCalls').val() ? $('#oppFieldCalls').val() : "0.00")).toFixed(1)
		);
	}
}

function calculateJfrrRemainder(){
	$('#ppcDIAG').val(
		(parseFloat($('#ppcFieldCalls').val() ? $('#ppcFieldCalls').val() : "0.00")
			+
			parseFloat($('#attemptFieldCalls').val() ? $('#attemptFieldCalls').val() : "0.00")).toFixed(2)
	);
  $('#lolDIAG').val(
    (parseFloat($('#oppFieldCalls').val() ? $('#oppFieldCalls').val() : "0.00")
      -
      parseFloat($('#ppcDIAG').val() ? $('#ppcDIAG').val() : "0.00")).toFixed(2)
    )
};

// Enable/disable "attemptFieldCalls" based on approval selection
function approvalToggle() {
	var appStatus = "APPROVED";
	var appStatusField = $('#approvalSelectCalls').val();
	if (appStatusField === appStatus) {
		$('#attemptFieldCalls').prop( "disabled", true );
	} else {
		$('#attemptFieldCalls').prop( "disabled", false );
	};
};

// Check for alerts
function alertVal() {
	if ($('.alert-calls')[0]) {
		$('#alertModalCalls').modal('show');
	} else {
		formReceiptTemplate();
		otlVal();
		$('#completionModalCalls').modal('show');
	}
}

// Completion receipts for modals
function formReceiptTemplate() {
  $('#est1ReceiptCalls').val(
    Date() + ' '  + $('#soNumberCalls').val()
    +'\n '
    +'\nName of s/p and person supplying estimate: '  + $('#callerNameCalls').val() + ' @ ' + $('#servicerNameCalls').val()
    +'\nModel number: ' + $('#modelNumberCalls').val()
    +'\nSerial number: ' + $('#serialNumberCalls').val()
    +'\nCause of Failure: ' + $('#failureCauseCalls').val()
    +'\nManufacturer\'s Warranty Link: ' + $('#warrantyLinkCalls').val()
    +'\nPlan SKU: ' + $('#skuFieldCalls').val()
    +'\n*If exception exists for this MFG refer service provider to the manufacturer if within exception period.* '
    +'\n '
    +'\nOPP: $'+ $('#oppFieldCalls').val() +' Previous Paid Claims: $'+ $('#ppcFieldCalls').val() +' Limit of Liability: $' + $('#lolFieldCalls').val()
    +'\nWhere were part prices verified: ' + $('#distributorFieldCalls').val()
    +'\nTotal Parts: $'+ $('#partsFieldCalls').val() +' Labor: $'+ $('#laborFieldCalls').val() +' Tax: $' + $('#taxFieldCalls').val()
    +'\nMileage: $' + $('#mileageFieldCalls').val() +' Misc: $'+ $('#miscFieldCalls').val()
    +'\nDeductible (if applicable): $' + $('#deductibleFieldCalls').val()
    +'\nTotal Estimate: $' + $('#totalFieldCalls').val()
    +'\n___________________________'
    +'\nEstimate: ' + $('#approvalSelectCalls').val()
    +'\nAttempted Repair or Diagnostic Fee if Pending: $' + $('#attemptFieldCalls').val()
    +'\nPre-Approval Code: '
    +'\n'
    +'\n"As a reminder, all pre-approvals are contingent upon verification of your contracted or agreed upon service rates. Contracted rates supersede preliminary estimates and approvals".' 
  );
  $('#est1ReceiptCallsJetsons').val(
    Date() + ' '  + $('#soNumberCalls').val()
    +'\n '
    +'\nName of s/p and person supplying estimate: '  + $('#callerNameCalls').val() + ' @ ' + $('#servicerNameCalls').val()
    +'\nModel number: ' + $('#modelNumberCalls').val()
    +'\nSerial number: ' + $('#serialNumberCalls').val()
    +'\nCause of Failure: ' + $('#failureCauseCalls').val()
    +'\nManufacturer\'s Warranty Link: ' + $('#warrantyLinkCalls').val()
    +'\nPlan SKU: ' + $('#skuFieldCalls').val()
    +'\n*If exception exists for this MFG refer service provider to the manufacturer if within exception period.* '
    +'\n '
    +'\nOPP: $'+ $('#oppFieldCalls').val() +' Previous Paid Claims: $'+ $('#ppcFieldCalls').val() +' Limit of Liability: $' + $('#lolFieldCalls').val()
    +'\nWhere were part prices verified: ' + $('#distributorFieldCalls').val()
    +'\nTotal Parts: $'+ $('#partsFieldCalls').val() +' Labor: $'+ $('#laborFieldCalls').val() +' Tax: $' + $('#taxFieldCalls').val()
    +'\nMileage: $' + $('#mileageFieldCalls').val() +' Misc: $'+ $('#miscFieldCalls').val()
    +'\nDeductible (if applicable): $' + $('#deductibleFieldCalls').val()
    +'\nTotal Estimate: $' + $('#totalFieldCalls').val()
    +'\n___________________________'
    +'\nEstimate: ' + $('#approvalSelectCalls').val()
    +'\nAttempted Repair or Diagnostic Fee if Pending: $' + $('#attemptFieldCalls').val()
    +'\nPre-Approval Code: '
    +'\n'
    +'\n"As a reminder, all pre-approvals are contingent upon verification of your contracted or agreed upon service rates. Contracted rates supersede preliminary estimates and approvals."'
    +'\n'
    +'\n**Parts Verification Process**'
    +'\n"Please note, final claim approval is contingent on technician contacting New Leaf through the parts verification line at (855) 868-5820 at the time of service (prior to installing parts) for New Leaf to obtain parts verification by the customer. Additionally, service provider is required to submit a SIGNED Parts Invoice by the customer at completion. FAILURE TO FOLLOW THIS PROCEDURE WILL RESULT IN CLAIM PAYMENT BEING REJECTED."' 
  );
  $('#jfrrReceiptCalls').val(
    Date() + ' '  + $('#soNumberCalls').val()
    +'\n '    
    +'\nJustification for Replacement Review (why) :  '
    +'\nInitial purchase price of unit (OPP): '  + $('#oppFieldCalls').val()
    +'\nAttempted Repair or Diagnostic Fee: ' + $('#attemptFieldCalls').val()
    +'\nTotal of all previous paid, pending and current owed clams: ' + $('#ppcDIAG').val()
    +'\nRemaining LOL: ' + $('#lolDIAG').val()
    +'\n(If Diag was done please enter total amount of estimate here): ' + $('#totalFieldCalls').val()
    +'\nIs Proof of Purchase required? Yes _____        No _____'
    +'\nIf Yes make sure it been received'
    +'\nIf open SO was dispatched you will need to create Sub SO and assigned to Pending Review'
    +'\n '   
    +'\n--------------------------------------------------------------'    
    +'\n '     
  );
}

function appendTemplate(){
    var pasteTime = document.getElementById("est1ReceiptCalls").value;    
    document.getElementById("historyField").value += pasteTime;
    var pasteTime3 = document.getElementById("jfrrReceiptCalls").value;    
    document.getElementById("historyField").value += pasteTime3;
    $('#callsForm').trigger('reset');
	$('.alert-calls').removeClass('alert-calls bg-warning').addClass('text-muted');
  $('#est1ReceiptCallsJetsons').prop('hidden', true);
  $('#est1ReceiptCalls').prop('hidden', false);
}

// 
// EMAILS TAB
// 
// 
// Prevent enter from form submission
$("#emailsForm").submit(function(e){ 
        e.preventDefault();
    });

// Event listeners
$('#spCodeEmails').on('blur',function(){
     spVerification2()
});

$('#skuFieldEmails').on('blur',function(){
	$('#skuAlertEmails').removeClass("alert-emails");
     skuVerification2()
});

$('#ppcFieldEmails').on('blur',function(){
     calculateLiabilities2();
});

$('#oppFieldEmails').on('change',function(){
     calculateLiabilities2();
     calculateTotal2();
});

$('#ppcFieldEmails').on('change',function(){
     calculateLiabilities2();
     calculateTotal2();
});

$('#partsFieldEmails').on('blur',function(){
     calculateTotal2();
});

$('#laborFieldEmails').on('blur',function(){
     calculateTotal2();
});

$('#taxFieldEmails').on('blur',function(){
     calculateTotal2();
});

$('#mileageFieldEmails').on('blur',function(){
     calculateTotal2();
});

$('#miscFieldEmails').on('blur',function(){
     calculateTotal2();
});

$('#deductibleFieldEmails').on('blur',function(){
     calculateTotal2();
});

$('#totalFieldEmails').on('blur',function(){
     calculateTotal2();
});

$('#totalLolFieldEmails').on('blur',function(){
     calculateTotal2();
});

$('#attemptFieldEmails').on('blur',function(){
     calculateTotal2();
     calculateJfrrRemainder2();
});

$('#approvalSelectEmails').on('change', function(){
	approvalToggle2();
})

$('#rspCheckEmails').on('click', function(){
	calculateTotal2();
	calculateLiabilities2();
})

$('#alertVerifiedEmails').on('click',function(){
    if ($('.collapse').hasClass('show')) {
    	alert('Please acknowledge all alerts first');
    } else {
	   	$('#alertModalEmails').modal('hide');
	    formReceiptTemplate2();
	    otlVal2();
	    $('#completionModalEmails').modal('show');
    };
});

$('#extCheckEmails').on('click',function(){
    if ($('#extCheckEmails').prop('checked') == true) {
    	$('#extensionModalEmails').modal('show');
    	$('.mirror2').on('keyup', function(){
  			$('.mirror2').val($(this).val());
		});
		$('#extAlertEmails').addClass('alert-emails');
		$('#extCollapseEmails').addClass('show');
	} else {
		$('#extCollapseEmails').removeClass('show');
		$('#extAlertEmails').removeClass('alert-emails');
	}
});

$('#samCheckEmails').on('click', function(){
	$('#modelNumberEmails').removeClass("alert-emails bg-warning");
	$('#serialNumberEmails').removeClass("alert-emails bg-warning");
	samVal2();
})

// Reset button
$('#resetEmails').on('click', function(){
	$('#emailsForm').trigger('reset');
	$('.alert-emails').removeClass('alert-emails bg-warning').addClass('text-muted');
  $('#est1ReceiptEmailsJetsons').prop('hidden', true);
  $('#est1ReceiptEmails').prop('hidden', false);
})

// Email over limits
$('#emailFormButtonEmails').on('click',function(){
     emailOTL2();
     $('#emailFormButtonEmails').prop('disabled', true);
     $('#emailFormButtonEmails').html("SENT");
});

// OTL ajax and such
function emailOTL2() {
    $.ajax({
      url: 'validator_email',
      type: 'put',
      data: { 
        username: $('#username').val(),
        receipt: $('#est1ReceiptEmails').val(),
        caller_name: $('#callerNameEmails').val(), 
        service_provider: $('#servicerNameEmails').val(), 
        model_number: $('#modelNumberEmails').val(), 
        serial_number: $('#serialNumberEmails').val(), 
        failure_cause: $('#failureCauseEmails').val(), 
        warranty_link: $('#warrantyLinkEmails').val(), 
        sku: $('#skuFieldEmails').val(), 
        opp: $('#oppFieldEmails').val(), 
        ppc: $('#ppcFieldEmails').val(),
        lol: $('#lolFieldEmails').val(),
        distributor: $('#distributorFieldEmails').val(),
        total_parts: $('#partsFieldEmails').val(),
        total_labor: $('#laborFieldEmails').val(),
        total_tax: $('#taxFieldEmails').val(),
        total_mileage: $('#mileageFieldEmails').val(),
        total_misc: $('#miscFieldEmails').val(),
        total_deductible: $('#deductibleFieldEmails').val(),
        total_estimate: $('#totalFieldEmails').val(),
        approved: $('#approvalSelectEmails').val(),
        diagnostic: $('#attemptFieldEmails').val(),
        serviceorder: $('#soNumberEmails').val() 
      }
    })
}

function otlVal2() {
  if ($('#totalFieldEmails').val() > 849.99) {
    $('#emailFormButtonEmails').prop('hidden', false)
  } else {
    $('#emailFormButtonEmails').prop('hidden', true)
  }
}

// Samsung model/serial verification to see if it lands under the ice maker warranty
function samVal2() {
	var modVal2 = $('#modelNumberEmails').val();
	var serVal2 = $('#serialNumberEmails').val();
	var aVal2 = a2();
	function a2() {
    	var snArray2 = ['HC', 'J1', 'J2', 'J3', 'J4', 'J5', 'J6', 'J7', 'J8', 'J9'];
    	for (var i = 0; i < snArray2.length; i++) {
    		if ((serVal2.toUpperCase().includes(snArray2[i], 5) === true) && (modVal2.toUpperCase().includes("RF", 0-2) == true)) {
        		$('#modelNumberEmails').addClass("alert-emails");
            $('#serialNumberEmails').addClass("alert-emails"); 
        		$('#samAlertEmails').addClass("alert-emails");
            $('#samCollapseEmails').addClass('show'); 
    		};
    	};
	};
};

//SKU Verification
function skuVerification2() {
    var triggerWords2 = ['MJC5', 'GMJC5', 'MJC10', 'MJC5-V', 'MJC10-NC', 'MJC210', 'D-MJC10', 'D-MJC210', 'MJR10', 'MJC5E', 'MJC5-NC', 'MJC8', 'MJC10-NL', 'NLMJC10', 'GMJC10', 'MJC10NLF', 'MJR5', 'RPL1U50', 'RPL1U100', 'RPL1U200', 'RPL1U300', 'RPL1U400', 'RPL1U500', 'RPL1U750', 'RPL1U1000', 'RPL2U50', 'RPL2U100', 'RPL2U200', 'RPL2U300', 'RPL2U400', 'RPL2U500', 'RPL2U1000'];
    for (var i = 0; i < triggerWords2.length; i++) {
        if ($('#skuFieldEmails').val().toUpperCase() == triggerWords2[i]) {
            $('#skuAlertEmails').addClass("alert-emails");
            $('#skuCollapseEmails').addClass('show');
        }
    }; 
};

//SP Verification
function spVerification2() {
    var triggerCodes2 = ['SP-NL-AMEX', 'S-SEAN-HIC'];
    var jetsonCode2 = 'S-1004-JET';
    for (var i = 0; i < triggerCodes2.length; i++) {
        if ($('#spCodeEmails').val().toUpperCase() == triggerCodes2[i] || $('#spCodeEmails').val().toUpperCase() == (" " + triggerCodes2[i])) {
            alert('Credit Card Provider, fill out credit card tab'); 
        } else if ($('#spCodeEmails').val().toUpperCase() == jetsonCode2 || $('#spCodeEmails').val().toUpperCase() == (" " + jetsonCode2)) {
        	$('#est1ReceiptEmailsJetsons').prop('hidden', false);
        	$('#est1ReceiptEmails').prop('hidden', true);
        } else {
        	$('#est1ReceiptEmailsJetsons').prop('hidden', true);
        	$('#est1ReceiptEmails').prop('hidden', false);
        }; 
	}; 
};

// Limit of Liability calculations "calculateLiabilities" & "calculateTotal"
function calculateLiabilities2() {
	if ($('#rspCheckEmails').prop('checked') && $('#ppcFieldEmails').val() > 0) {
		$('#lolFieldEmails').val(
			(parseFloat($('#oppFieldEmails').val() ? $('#oppFieldEmails').val() : "0.00")
			-
			parseFloat($('#ppcFieldEmails').val() ? $('#ppcFieldEmails').val() : "0.00")
			-
			250).toFixed(2)
		);
		if ($('#lolFieldEmails').val() <= 0) {
			$('#lolAlertEmails').addClass('alert-emails');
			$('#lolCollapseEmails').addClass('show');
		} else {
			$('#lolAlertEmails').removeClass('alert-emails');
			$('#lolCollapseEmails').removeClass('show');
		}
		$('#lolPercFieldEmails').val(
			(parseFloat($('#lolFieldEmails').val() ? $('#lolFieldEmails').val() : "0.00")
			*
			100
			/
			parseFloat($('#oppFieldEmails').val() ? $('#oppFieldEmails').val() : "0.00")).toFixed(1)
		);
		if ($('#lolPercFieldEmails').val() < 30) {
			$('#rspAlertEmails').removeClass('text-muted').addClass('alert-emails');
			$('#rspCollapseEmails').addClass('show');
			$('#lolPercFieldEmails').removeClass('text-muted').addClass('alert-emails bg-warning');
		} else {
			$('#rspAlertEmails').removeClass('alert-emails').addClass('text-muted');
			$('#rspCollapseEmails').removeClass('show');
			$('#lolPercFieldEmails').removeClass('alert-emails bg-warning').addClass('text-muted');
		}
	}
	else {
		$('#lolFieldEmails').val(
			(parseFloat($('#oppFieldEmails').val() ? $('#oppFieldEmails').val() : "0.00")
			-
			parseFloat($('#ppcFieldEmails').val() ? $('#ppcFieldEmails').val() : "0.00")).toFixed(2)
		);
		$('#lolPercFieldEmails').val(
			(parseFloat($('#lolFieldEmails').val() ? $('#lolFieldEmails').val() : "0.00")
			*
			100
			/
			parseFloat($('#oppFieldEmails').val() ? $('#oppFieldEmails').val() : "0.00")).toFixed(1)
		);
		if ($('#lolFieldEmails').val() <= 300) {
			$('#300AlertEmails').addClass('alert-emails');
			$('#300CollapseEmails').addClass('show');
		} else {
			$('#300AlertEmails').removeClass('alert-emails');
			$('#300CollapseEmails').removeClass('show');
		}
	};
};

function calculateTotal2() {
	if ($('#rspCheckEmails').prop('checked') && $('#ppcFieldEmails').val() == 0) {
		$('#totalFieldEmails').val(
			(parseFloat($('#partsFieldEmails').val() ? $('#partsFieldEmails').val() : "0.00")
			+
			parseFloat($('#laborFieldEmails').val() ? $('#laborFieldEmails').val() : "0.00")
			+
			parseFloat($('#taxFieldEmails').val() ? $('#taxFieldEmails').val() : "0.00")
			+
			parseFloat($('#mileageFieldEmails').val() ? $('#mileageFieldEmails').val() : "0.00")
			+
			parseFloat($('#miscFieldEmails').val() ? $('#miscFieldEmails').val() : "0.00")
			-
			parseFloat($('#deductibleFieldEmails').val() ? $('#deductibleFieldEmails').val() : "0.00")).toFixed(2)
		);
		$('#totalLolFieldEmails').val(
			(parseFloat($('#lolFieldEmails').val() ? $('#lolFieldEmails').val() : "0.00")
			-
			parseFloat($('#totalFieldEmails').val() ? $('#totalFieldEmails').val() : "0.00")).toFixed(2)
		)
		$('#totalLolPercFieldEmails').val(
			(parseFloat($('#totalLolFieldEmails').val() ? $('#totalLolFieldEmails').val() : "0.00")
			*
			100
			/
			parseFloat($('#oppFieldEmails').val() ? $('#oppFieldEmails').val() : "0.00")).toFixed(1)
		);
		if ($('#totalLolPercFieldEmails').val() < 30) {
			$('#rspAlertCallsEmails').removeClass('text-muted').addClass('alert-emails');
			$('#totalLolPercFieldEmails').removeClass('text-muted').addClass('alert-emails bg-warning');
		}
	}
	else {
		$('#totalFieldEmails').val(
			(parseFloat($('#partsFieldEmails').val() ? $('#partsFieldEmails').val() : "0.00")
			+
			parseFloat($('#laborFieldEmails').val() ? $('#laborFieldEmails').val() : "0.00")
			+
			parseFloat($('#taxFieldEmails').val() ? $('#taxFieldEmails').val() : "0.00")
			+
			parseFloat($('#mileageFieldEmails').val() ? $('#mileageFieldEmails').val() : "0.00")
			+
			parseFloat($('#miscFieldEmails').val() ? $('#miscFieldEmails').val() : "0.00")
			-
			parseFloat($('#deductibleFieldEmails').val() ? $('#deductibleFieldEmails').val() : "0.00")).toFixed(2)
		);
		$('#totalLolFieldEmails').val(
			(parseFloat($('#lolFieldEmails').val() ? $('#lolFieldEmails').val() : "0.00")
			-
			parseFloat($('#totalFieldEmails').val() ? $('#totalFieldEmails').val() : "0.00")).toFixed(2)
		)
		$('#totalLolPercFieldEmails').val(
			(parseFloat($('#totalLolFieldEmails').val() ? $('#totalLolFieldEmails').val() : "0.00")
			*
			100
			/
			parseFloat($('#oppFieldEmails').val() ? $('#oppFieldEmails').val() : "0.00")).toFixed(1)
		);
	}
}

function calculateJfrrRemainder2(){
	$('#ppcDIAGEmails').val(
		(parseFloat($('#ppcFieldEmails').val() ? $('#ppcFieldEmails').val() : "0.00")
			+
			parseFloat($('#attemptFieldEmails').val() ? $('#attemptFieldEmails').val() : "0.00")).toFixed(2)
	);
  $('#lolDIAGEmails').val(
    (parseFloat($('#oppFieldEmails').val() ? $('#oppFieldEmails').val() : "0.00")
      -
      parseFloat($('#ppcDIAGEmails').val() ? $('#ppcDIAGEmails').val() : "0.00")).toFixed(2)
    )
};

// Enable/disable "attemptFieldCalls" based on approval selection
function approvalToggle2() {
	var appStatus2 = "APPROVED";
	var appStatusField2 = $('#approvalSelectEmails').val();
	if (appStatusField2 === appStatus2) {
		$('#attemptFieldEmails').prop( "disabled", true );
	} else {
		$('#attemptFieldEmails').prop( "disabled", false );
	};
};

// Check for alerts
function alertVal2() {
	if ($('.alert-emails')[0]) {
		$('#alertModalEmails').modal('show');
	} else {
		formReceiptTemplate2();
		otlVal2();
		$('#completionModalEmails').modal('show');
	}
}

// Completion receipts for modals
function formReceiptTemplate2() {
  $('#est1ReceiptEmails').val(
    Date() + ' '  + $('#soNumberEmails').val()
    +'\n '
    +'\nName of s/p and person supplying estimate: '  + $('#callerNameEmails').val() + ' @ ' + $('#servicerNameEmails').val()
    +'\nModel number: ' + $('#modelNumberEmails').val()
    +'\nSerial number: ' + $('#serialNumberEmails').val()
    +'\nCause of Failure: ' + $('#failureCauseEmails').val()
    +'\nManufacturer\'s Warranty Link: ' + $('#warrantyLinkEmails').val()
    +'\nPlan SKU: ' + $('#skuFieldEmails').val()
    +'\n*If exception exists for this MFG refer service provider to the manufacturer if within exception period.* '
    +'\n '
    +'\nOPP: $'+ $('#oppFieldEmails').val() +' Previous Paid Claims: $'+ $('#ppcFieldEmails').val() +' Limit of Liability: $' + $('#lolFieldEmails').val()
    +'\nWhere were part prices verified: ' + $('#distributorFieldEmails').val()
    +'\nTotal Parts: $'+ $('#partsFieldEmails').val() +' Labor: $'+ $('#laborFieldEmails').val() +' Tax: $' + $('#taxFieldEmails').val()
    +'\nMileage: $' + $('#mileageFieldEmails').val() +' Misc: $'+ $('#miscFieldEmails').val()
    +'\nDeductible (if applicable): $' + $('#deductibleFieldEmails').val()
    +'\nTotal Estimate: $' + $('#totalFieldEmails').val()
    +'\n___________________________'
    +'\nEstimate: ' + $('#approvalSelectEmails').val()
    +'\nAttempted Repair or Diagnostic Fee if Pending: $' + $('#attemptFieldEmails').val()
    +'\nPre-Approval Code: '
    +'\n'
    +'\n"As a reminder, all pre-approvals are contingent upon verification of your contracted or agreed upon service rates. Contracted rates supersede preliminary estimates and approvals".' 
  );
  $('#est1ReceiptEmailsJetsons').val(
    Date() + ' '  + $('#soNumberEmails').val()
    +'\n '
    +'\nName of s/p and person supplying estimate: '  + $('#callerNameEmails').val() + ' @ ' + $('#servicerNameEmails').val()
    +'\nModel number: ' + $('#modelNumberEmails').val()
    +'\nSerial number: ' + $('#serialNumberEmails').val()
    +'\nCause of Failure: ' + $('#failureCauseEmails').val()
    +'\nManufacturer\'s Warranty Link: ' + $('#warrantyLinkEmails').val()
    +'\nPlan SKU: ' + $('#skuFieldEmails').val()
    +'\n*If exception exists for this MFG refer service provider to the manufacturer if within exception period.* '
    +'\n '
    +'\nOPP: $'+ $('#oppFieldEmails').val() +' Previous Paid Claims: $'+ $('#ppcFieldEmails').val() +' Limit of Liability: $' + $('#lolFieldEmails').val()
    +'\nWhere were part prices verified: ' + $('#distributorFieldEmails').val()
    +'\nTotal Parts: $'+ $('#partsFieldEmails').val() +' Labor: $'+ $('#laborFieldEmails').val() +' Tax: $' + $('#taxFieldEmails').val()
    +'\nMileage: $' + $('#mileageFieldEmails').val() +' Misc: $'+ $('#miscFieldEmails').val()
    +'\nDeductible (if applicable): $' + $('#deductibleFieldEmails').val()
    +'\nTotal Estimate: $' + $('#totalFieldEmails').val()
    +'\n___________________________'
    +'\nEstimate: ' + $('#approvalSelectEmails').val()
    +'\nAttempted Repair or Diagnostic Fee if Pending: $' + $('#attemptFieldEmails').val()
    +'\nPre-Approval Code: '
    +'\n'
    +'\n"As a reminder, all pre-approvals are contingent upon verification of your contracted or agreed upon service rates. Contracted rates supersede preliminary estimates and approvals.' 
    +'\n'
    +'\n**Parts Verification Process**'
    +'\n"Please note, final claim approval is contingent on technician contacting New Leaf through the parts verification line at (855) 868-5820 at the time of service (prior to installing parts) for New Leaf to obtain parts verification by the customer. Additionally, service provider is required to submit a SIGNED Parts Invoice by the customer at completion. FAILURE TO FOLLOW THIS PROCEDURE WILL RESULT IN CLAIM PAYMENT BEING REJECTED."' 
   );
  $('#jfrrReceiptEmails').val(
    Date() + ' '  + $('#soNumberEmails').val()
    +'\n '    
    +'\nJustification for Replacement Review (why) :  '
    +'\nInitial purchase price of unit (OPP): '  + $('#oppFieldEmails').val()
    +'\nAttempted Repair or Diagnostic Fee: ' + $('#attemptFieldEmails').val()
    +'\nTotal of all previous paid, pending and current owed clams: ' + $('#ppcDIAGEmails').val()
    +'\nRemaining LOL: ' + $('#lolDIAGEmails').val()
    +'\n(If Diag was done please enter total amount of estimate here): ' + $('#totalFieldEmails').val()
    +'\nIs Proof of Purchase required? Yes _____        No _____'
    +'\nIf Yes make sure it been received'
    +'\nIf open SO was dispatched you will need to create Sub SO and assigned to Pending Review'
    +'\n '   
    +'\n--------------------------------------------------------------'    
    +'\n '     
  );
}

function appendTemplate2(){
    var pasteTime2 = document.getElementById("est1ReceiptEmails").value;    
    document.getElementById("historyField").value += pasteTime2;
    var pasteTime4 = document.getElementById("jfrrReceiptEmails").value;    
    document.getElementById("historyField").value += pasteTime4;
    $('#emailsForm').trigger('reset');
	$('.alert-emails').removeClass('alert-emails bg-warning').addClass('text-muted');
  $('#est1ReceiptEmailsJetsons').prop('hidden', true);
  $('#est1ReceiptEmails').prop('hidden', false);
}
;
