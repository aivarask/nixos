/*
Copyright (c) 2003-2010, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

CKEDITOR.editorConfig = function( config )
{
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	// config.uiColor = '#AADC6E';
	//filebrowserBrowseUrl: '/lib/ckeditor/filemanager/index.html',
	config.toolbar = 'Default';

	config.toolbar_Default = [
	['Source','PasteText','PasteFromWord','RemoveFormat','Link','Unlink','Anchor','Table','contactform','Products'],
	['Format','Bold','Italic','Underline','Strike', 'TextColor'],
	['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
	['Outdent','Indent','-','NumberedList','BulletedList'],
	['Image','Maximize']
	] ;


	/* FullToolbar
 * ['Source','-','Save','NewPage','Preview','-','Templates'],
    ['Cut','Copy','Paste','PasteText','PasteFromWord','-','Print', 'SpellChecker', 'Scayt'],
    ['Undo','Redo','-','Find','Replace','-','SelectAll','RemoveFormat'],
    ['Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select', 'Button', 'ImageButton', 'HiddenField'],
    '/',
    ['Bold','Italic','Underline','Strike','-','Subscript','Superscript'],
    ['NumberedList','BulletedList','-','Outdent','Indent','Blockquote','CreateDiv'],
    ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
    ['Link','Unlink','Anchor'],
    ['Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak'],
    '/',
    ['Styles','Format','Font','FontSize'],
    ['TextColor','BGColor'],
    ['Maximize', 'ShowBlocks','-','About']

 *
 */


	config.toolbar_Basic = [
	['Source','PasteText','PasteFromWord','RemoveFormat','Link','Unlink','Table'],
	['Bold','Italic','Underline','Strike', 'TextColor'],
	['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
	['NumberedList','BulletedList'],
	['Image']
	] ;

	config.enterMode = 1 ;			// p | br | div
	config.shiftEnterMode = 2 ;	// p | br | div
	config.skin = 'v2'; // v2 | kama | office2003
	config.defaultLanguage = 'lt';
	config.format_tags = 'p;h2;h3;h4;h5;h6;pre;address;div';
	config.forcePasteAsPlainText = true;
	config.protectedSource.push(/<video[\s|\S]+?<\/video>/g);
};

CKEDITOR.on('instanceReady', function (ev) {
	const blockTags = ['div', 'p'];

	for (let i = 0; i < blockTags.length; i++) {
		ev.editor.dataProcessor.writer.setRules(blockTags[i], {
			indent: true,
			breakBeforeOpen: true,
			breakAfterOpen: false,
			breakBeforeClose: false,
			breakAfterClose: true
		});
	}
});
