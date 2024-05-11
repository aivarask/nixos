$( document ).ready(function() {
	$('a.call-duk-menu').on('click', function(){
		$('a.call-duk-menu').hide();
		$('.admin-duk-menu, body').addClass('active-duk');
		$('#admin-helper').append('<a href="javascript:;" class="duk-menu-bck"><!-- --></a>');
		$('a.duk-menu-bck').on('click', function(){
			$('.admin-duk-menu, body').removeClass('active-duk');
			$(this).remove();
			$('a.call-duk-menu').show();
		});

		let currentMenu = $('#admin-main-menu li.current').closest('.admin-fat-menu').find('.admin-fat-menu-big-cat').text();
		
		$('ul.pagalba-menu-collapse').attr('style', 'display: none;');

		if (currentMenu.length !== 0) {
			$('a.pagalba-menu:contains("'+ currentMenu +'")').click();
		}
		else {
			$('a.pagalba-menu:contains("Pradžia")').click();
		}
	});

	$('.admin-duk-menu .close-menu, a.duk-menu-bck').on('click', function(){
		$('.admin-duk-menu, body').removeClass('active-duk');
		$('#admin-helper .duk-menu-bck').remove();
		$('a.call-duk-menu').show();
		$('.close-modal').click();
	});
	
	$('.admin-duk-menu .title a').on('click', function(){
		$(this).toggleClass('collapsed').parent().next('.pagalba-menu-collapse').slideToggle('fast').toggleClass('collapsed');
	});
	
	$('.call-modal').on('click', function(){
		var modalTarget = $(this).data("target");
		$(modalTarget).show("fast", function() {
			$(modalTarget).addClass('show');
		});

		$('form[name="admin-duk-messaage"] #message-status').remove();
		$('.modal-footer a[data-action="message-send"]').removeClass('disabled');
		$('.modal-footer a[data-action="message-send"]').removeAttr('disabled');
	});
	
	$('.close-modal').on('click', function(){
		var modalTarget = $(this).data("dismiss");
		$(modalTarget).removeClass('show').hide();
	});

	$('form[name="admin-duk-messaage"] a[data-action="message-send"]:not(:disabled)').on('click', function(){

		if ($(this).attr('disabled') == "disabled") return;
		if ($('form[name="admin-duk-messaage"] #message-status').length > 0) {
			$('form[name="admin-duk-messaage"] #message-status').remove();
		}

		const formData = {
			domain: window.location.host,
			pathname: window.location.pathname,
			name: $('form[name="admin-duk-messaage"] #name').val(),
			email: $('form[name="admin-duk-messaage"] #email').val(),
			phone: $('form[name="admin-duk-messaage"] #phone').val(),
			s1: $('form[name="admin-duk-messaage"] #s1').find(":selected").text(),
			s2: $('form[name="admin-duk-messaage"] #s2').find(":selected").text(),
			message: $('form[name="admin-duk-messaage"] #message').val()
		};

		formData.message = formData.message.replace(/(?:\r\n|\r|\n)/g, '<br>');

		if (formData.name.length == 0) {
			$('form[name="admin-duk-messaage"] .modal-body').append(messageStatus('Neįvestas siuntėjo vardas!', 'error'));
			return;
		}
		if (formData.email.length == 0) {
			$('form[name="admin-duk-messaage"] .modal-body').append(messageStatus('Neįvestas el. pašto adresas!', 'error'));
			return;
		}
		if (formData.message.length == 0) {
			$('form[name="admin-duk-messaage"] .modal-body').append(messageStatus('Neįvestas žinutės tekstas!', 'error'));
			return;
		}

		const messageLimit = 5000;
		if (formData.message.length >= messageLimit) {
			$('form[name="admin-duk-messaage"] .modal-body').append(messageStatus('Žinutės tekstas viršija simbolių limitą! ('+ formData.message.length +' / '+ messageLimit +' simbolių)', 'error'));
			return;
		}
		

		fetch("https://www.verskis.lt/admin-help/message/index.php", {
			method: 'POST',
			body: JSON.stringify(formData)
		}).then(response => response.json()).then(data => {
			if (data.success == true) {
				$('.modal-footer a[data-action="message-send"]').addClass('disabled');
				$('.modal-footer a[data-action="message-send"]').attr('disabled', 'disabled');
				$('form[name="admin-duk-messaage"] .modal-body').append(messageStatus('Žinutė išsiųsta!', 'success'));
			}
			else {
				$('form[name="admin-duk-messaage"] #message-status').remove();
				$('form[name="admin-duk-messaage"] .modal-body').append(messageStatus('Error: '+error, 'error'));
				return;
			}
		}).catch(error => {
			// Handle errors
			$('form[name="admin-duk-messaage"] #message-status').remove();
			$('form[name="admin-duk-messaage"] .modal-body').append(messageStatus('Įvyko klaida! Bandykite išsiųsti žinutę vėliau.', 'error'));
			return;
		});
	});

	$('#s1').on('change', function() {
		var s1Value = this.value;
		var s2Options = $('#s2 options');
	
		for (var i = 0; i < s2Options.length; i++) {
		  var option = s2Options[i];
		  if (option.classList.contains(s1Value)) {
			option.style.display = '';
		  } else {
			option.style.display = 'none';
		  }
		}
	});

	let s1Value = $('#s1').val();
	$('#s2 option').hide();
	if (s1Value == 1) {
		$('#s2 option[value="1"]').show();
		$('#s2 option[value="2"]').show();
		$('#s2 option[value="3"]').show();
	}

	$('#s1').on('change', function() {
		let s1Value = $(this).val();

		$('#s2 option').hide().attr('selected', false);
		if (s1Value == 1) {
			for (var i = 1; i < 3; i++) {
				$('#s2 option[value="'+ i +'"]').show();
				$('#s2 option[value="1"]').attr('selected', true);
			}
		}
		if (s1Value == 2){
			for (var i = 4; i < 13; i++) {
				$('#s2 option[value="'+ i +'"]').show();
				$('#s2 option[value="4"]').attr('selected', true);
			}
		}
		if (s1Value == 3){
			for (var i = 14; i < 16; i++) {
				$('#s2 option[value="'+ i +'"]').show();
				$('#s2 option[value="14"]').attr('selected', true);
			}
		}
	});
});

function messageStatus(message, status) {
	return `<div id="message-status" style="width: 100%;"><div class="message ${status} mt10">${message}</div></div>`;
}